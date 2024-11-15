local path_helpers = require 'LazyLanguages.helpers.paths'
local conform = require 'conform'
local mason_registry = require 'mason-registry'
local lspconfig = require 'lspconfig'
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

local M = {}

local expanded_override_path = nil
if type(vim.g.lazylangs.override_path) == 'string' then
  expanded_override_path = vim.fn.stdpath 'config'
    .. path_helpers.path_separator
    .. 'lua'
    .. path_helpers.path_separator
    .. vim.g.lazylangs.override_path:gsub('%.', path_helpers.path_separator)
end

---Find and return a language table from the correct file
---@param language string
---@return ll.Language?
M.get_language_table = function(language)
  local error_msg = ' is not a supported language and no override path has been specified'

  if expanded_override_path ~= nil then
    error_msg = ' is not a supported language and has no override file provided'
    local override_file = expanded_override_path .. path_helpers.path_separator .. language .. '.lua'
    if path_helpers.file_exists(override_file) then
      return dofile(override_file)
    end
  end

  local success, tbl = pcall(require, 'LazyLanguages.languages.' .. language)
  ---@cast tbl ll.Language
  if success then
    return tbl
  else
    path_helpers.notify_once(string.format("'%s' %s", language, error_msg), vim.log.levels.WARN)
    return nil
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
      path_helpers.notify(string.format("Mason package '%s' has failed to install", package.name), vim.log.levels.ERROR)
    end)
  end)
  package:install { force = true }
end

M.language_setup = function()
  local mason_packages = {}

  for _, language in ipairs(vim.g.lazylangs.langs or {}) do
    local language_table = M.get_language_table(language)
    if language_table == nil then
      -- Error notification returned by get_language_table as it provides a more accurate error msg
      goto continue
    end

    -- Merge conform formatters_by_ft with the formatter settings in language file
    local language_formatters = conform.formatters_by_ft[language] or {}
    ---@diagnostic disable-next-line: param-type-mismatch
    language_formatters = vim.tbl_deep_extend('force', language_formatters, language_table.formatters or {})
    conform.formatters_by_ft[language] = language_formatters

    -- Take lsp configuration and merge it with the capabilities generated in the file.
    if language_table.lsp ~= nil then
      local lsp_config = vim.tbl_deep_extend('force', {}, {
        capabilities = capabilities,
      }, language_table.lsp.server_configuration or {})
      lspconfig[language_table.lsp.name].setup(lsp_config)
    end

    for _, package in ipairs(language_table.mason_packages or {}) do
      table.insert(mason_packages, package)
    end

    if language_table.setup ~= nil then
      language_table.setup()
    end

    ::continue::
  end

  vim.cmd 'filetype detect' -- Fixes single file not working on some language servers

  vim.api.nvim_create_user_command('LLMasonInstall', function()
    for _, package_name in ipairs(mason_packages) do
      local package_list = mason_registry.get_all_package_names()
      if not vim.tbl_contains(package_list, package_name) then
        path_helpers.notify(string.format("'%s' is not a valid mason package.", package_name), vim.log.levels.WARN)
      else
        local package = mason_registry.get_package(package_name)
        if not package:is_installed() then
          package_install(package)
        end
      end
    end
  end, {})

  vim.api.nvim_create_user_command('LLMasonUpdate', function()
    for _, package_name in ipairs(mason_packages) do
      local package_list = mason_registry.get_all_package_names()

      if not vim.tbl_contains(package_list, package_name) then
        path_helpers.notify(string.format("'%s' is not a valid mason package.", package_name), vim.log.levels.WARN)
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
