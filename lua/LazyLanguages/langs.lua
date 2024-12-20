local path_helpers = require 'LazyLanguages.helpers.paths'
local vim_helpers = require 'LazyLanguages.helpers.vim'

local M = {}

local expanded_override_path = nil
if type(vim.g.lazylangs.override_path) == 'string' then
  expanded_override_path = vim.fn.stdpath 'config'
    .. path_helpers.path_separator
    .. 'lua'
    .. path_helpers.path_separator
    .. vim.g.lazylangs.override_path:gsub('%.', path_helpers.path_separator)
end

M.language_tables = {}
for _, language in ipairs(vim.g.lazylangs.langs or {}) do
  local error_msg = ' is not a supported language and no override path has been specified'

  if expanded_override_path ~= nil then
    error_msg = ' is not a supported language and has no override file provided'
    local override_file = expanded_override_path .. path_helpers.path_separator .. language .. '.lua'
    if path_helpers.file_exists(override_file) then
      M.language_tables[language] = dofile(override_file)
    else
      local success, tbl = pcall(require, 'LazyLanguages.languages.' .. language)
      ---@cast tbl ll.Language
      if success then
        M.language_tables[language] = tbl
      else
        vim_helpers.notify_once(string.format("'%s' %s", language, error_msg), vim.log.levels.WARN)
      end
    end
  end
end

local show = vim.schedule_wrap(function(msg)
  vim.notify(msg, vim.log.levels.INFO, { title = 'LazyLanguages' })
end)

---@param package Package
local function package_install(package)
  show(string.format("Installing Mason package '%s'", package.name))
  package:once('install:success', function()
    show(string.format("Mason package '%s' has been successfully installed", package.name))
  end)
  package:once('install:failed', function()
    vim.schedule_wrap(function()
      vim_helpers.notify(string.format("Mason package '%s' has failed to install", package.name), vim.log.levels.ERROR)
    end)
  end)
  package:install { force = true }
end

local function handle_lsp(lsp_table, config, lspconfig)
  -- Take lsp configuration and merge it with the capabilities generated in the file.
  if lsp_table ~= nil then
    if lsp_table.name == nil then
      for _, lsp in ipairs(lsp_table) do
        local lsp_config = vim.tbl_deep_extend('force', {}, {
          capabilities = config.lsp.capabilities,
          on_attach = config.lsp.on_attach,
          flags = config.lsp.flags,
        }, lsp.server_configuration or {})
        lspconfig[lsp.name].setup(lsp_config)
      end
    else
      local lsp_config = vim.tbl_deep_extend('force', {}, {
        capabilities = config.lsp.capabilities,
        on_attach = config.lsp.on_attach,
        flags = config.lsp.flags,
      }, lsp_table.server_configuration or {})
      lspconfig[lsp_table.name].setup(lsp_config)
    end
  end
end

local function handle_nvim_lint(linter_table, lint)
  for filetype, linters in pairs(linter_table) do
    if lint.linters_by_ft[filetype] == nil then
      lint.linters_by_ft[filetype] = linters
    else
      for _, linter in ipairs(linters) do
        table.insert(lint.linters_by_ft[filetype], linter)
      end
    end
  end
end

M.language_setup = function()
  local _, conform = pcall(require, 'conform')
  local config = require 'LazyLanguages.config'
  local lspconfig = require 'lspconfig'
  local mason_packages = {}
  local linting_plugin = vim.g.lazylangs.linting_plugin or nil
  local lint
  if linting_plugin == 'nvim-lint' then
    local success
    success, lint = pcall(require, 'lint')
    if not success then
      require('LazyLanguages.helpers.vim').notify_once('nvim-lint is not installed', vim.log.levels.ERROR)
    end
  end

  for _, language in ipairs(vim.g.lazylangs.langs or {}) do
    local language_table = M.language_tables[language]
    if language_table.formatters ~= nil then
      -- Merge conform formatters_by_ft with the formatter settings in language file
      if config.formatting.plugin == 'conform' and language_table.formatters.conform ~= nil then
        local language_formatters = conform.formatters_by_ft[language] or {}
        ---@diagnostic disable-next-line: param-type-mismatch
        language_formatters = vim.tbl_deep_extend('force', language_formatters, language_table.formatters.conform or {})
        conform.formatters_by_ft[language] = language_formatters
      end
    end

    handle_lsp(language_table.lsp, config, lspconfig)
    if linting_plugin == 'nvim-lint' then
      handle_nvim_lint(language_table.linters, lint)
    end

    for _, package in ipairs(language_table.mason_packages or {}) do
      table.insert(mason_packages, package)
    end

    if language_table.setup ~= nil then
      language_table.setup()
    end
  end

  vim.api.nvim_create_user_command('LLMasonInstall', function()
    local mason_registry = require 'mason-registry'
    mason_registry.refresh()
    for _, package_name in ipairs(mason_packages) do
      local package_list = mason_registry.get_all_package_names()
      if not vim.tbl_contains(package_list, package_name) then
        vim_helpers.notify(string.format("'%s' is not a valid mason package.", package_name), vim.log.levels.WARN)
      else
        local package = mason_registry.get_package(package_name)
        if not package:is_installed() then
          package_install(package)
        end
      end
    end
  end, {})

  vim.api.nvim_create_user_command('LLMasonUpdate', function()
    local mason_registry = require 'mason-registry'
    for _, package_name in ipairs(mason_packages) do
      mason_registry.refresh()
      local package_list = mason_registry.get_all_package_names()

      if not vim.tbl_contains(package_list, package_name) then
        vim_helpers.notify(string.format("'%s' is not a valid mason package.", package_name), vim.log.levels.WARN)
      else
        local package = mason_registry.get_package(package_name)
        package:check_new_version(function(success, result_or_err)
          if success then
            if result_or_err.latest_version ~= result_or_err.current_version then
              package_install(package)
            end
          end
        end)
      end
    end
  end, {})

  vim.api.nvim_create_user_command('LLMasonClean', function()
    vim.cmd('MasonUninstall ' .. table.concat(mason_packages, ' '))
  end, {})
end

return M
