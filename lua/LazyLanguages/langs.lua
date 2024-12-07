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

M.language_setup = function()
  local conform = require 'conform'
  local config = require 'LazyLanguages.config'
  local lspconfig = require 'lspconfig'
  local mason_packages = {}

  for _, language in ipairs(vim.g.lazylangs.langs or {}) do
    local language_table = M.language_tables[language]
    -- Merge conform formatters_by_ft with the formatter settings in language file
    local language_formatters = conform.formatters_by_ft[language] or {}
    ---@diagnostic disable-next-line: param-type-mismatch
    language_formatters = vim.tbl_deep_extend('force', language_formatters, language_table.formatters or {})
    conform.formatters_by_ft[language] = language_formatters

    -- Take lsp configuration and merge it with the capabilities generated in the file.
    if language_table.lsp ~= nil then
      if language_table.lsp.name == nil then
        for _, lsp in ipairs(language_table.lsp) do
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
        }, language_table.lsp.server_configuration or {})
        lspconfig[language_table.lsp.name].setup(lsp_config)
      end
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
