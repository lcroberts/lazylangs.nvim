local utils = require 'LazyLanguages.utils'
local conform = require 'conform'
local mason_lspconfig = require('mason-lspconfig').get_mappings().lspconfig_to_mason
local mason_registry = require 'mason-registry'
local lspconfig = require 'lspconfig'
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

local function get_mason_package_name(string)
  for _, lsp in ipairs(vim.tbl_keys(mason_lspconfig)) do
    if string == lsp then
      return mason_lspconfig[string]
    end
  end
  return string
end

local M = {}

local expanded_override_path = nil
if type(vim.g.lazylangs.override_path) == 'string' then
  expanded_override_path = vim.fn.stdpath 'config'
    .. utils.path_separator
    .. 'lua'
    .. utils.path_separator
    .. vim.g.lazylangs.override_path:gsub('%.', utils.path_separator)
end

---Find and return a language table from the correct file
---@param language string
---@return ll.Language?
M.get_language_table = function(language)
  local error_msg = ' is not a supported language and no override path has been specified'

  if expanded_override_path ~= nil then
    error_msg = ' is not a supported language and has no override file provided'
    local override_file = expanded_override_path .. utils.path_separator .. language .. '.lua'
    if utils.file_exists(override_file) then
      return dofile(override_file)
    end
  end

  local success, tbl = pcall(require, 'LazyLanguages.languages.' .. language)
  ---@cast tbl ll.Language
  if success then
    return tbl
  else
    utils.notify("'" .. language .. "'" .. error_msg, { once = true, level = vim.log.levels.WARN })
    return nil
  end
end

local show = vim.schedule_wrap(function(msg)
  vim.notify(msg, vim.log.levels.INFO, { title = 'LazyLanguages' })
end)

local show_error = vim.schedule_wrap(function(msg)
  vim.notify(msg, vim.log.levels.ERROR, { title = 'LazyLanguages' })
end)

---@param package Package
local function package_install(package)
  show(string.format("Installing Mason package '%s'", package.name))
  package:once('install:success', function()
    show(string.format("Mason package '%s' has been successfully installed", package.name))
  end)
  package:once('install:failed', function()
    show_error(string.format("Mason package '%s' has failed to install", package.name), { level = vim.log.levels.ERROR })
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
      table.insert(mason_packages, get_mason_package_name(package))
    end

    if language_table.setup ~= nil then
      language_table.setup()
    end

    ::continue::
  end

  vim.cmd 'filetype detect' -- Fixes single file not working on some language servers

  vim.api.nvim_create_user_command('LLMasonInstall', function()
    for _, package_name in ipairs(mason_packages) do
      local package = mason_registry.get_package(package_name)
      if not package:is_installed() then
        package_install(package)
      end
    end
  end, {})

  vim.api.nvim_create_user_command('LLMasonClean', function()
    vim.cmd('MasonUninstall ' .. table.concat(mason_packages, ' '))
  end, {})
end

return M
