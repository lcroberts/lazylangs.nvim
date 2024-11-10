local utils = require 'LazyLanguages.utils'
local M = {}

--- @class ll.Config
local config = {
  ---Are mason packages for languages automatically installed
  ---@type boolean
  mason_install = false,
  ---Are mason packages for languages automatically updated
  ---@type boolean
  mason_update = false,
}

---@param opts? ll.Config
M.setup = function(opts)
  opts = opts or {}
  config = vim.tbl_deep_extend('keep', opts, config)

  require('LazyLanguages.lang_helpers').language_setup()

  vim.api.nvim_create_user_command('LLDumpConfig', function(options)
    if type(vim.g.lazylangs.override_path) ~= 'string' then
      utils.notify("'vim.g.lazylangs.override_path' must be declared in order to dump the existing config", { level = vim.log.levels.ERROR })
      return
    end
    local language = string.lower(options.args)
    local success, _ = pcall(require, 'LazyLanguages.languages.' .. language)
    if not success then
      utils.notify("'" .. language .. "' is not a language supported by LazyLanguages", { level = vim.log.levels.WARN })
      return
    end
    local plugin_path = nil
    for _, plugin in ipairs(require('lazy').plugins()) do
      if plugin.name == 'LazyLanguages.nvim' then
        plugin_path = plugin.dir
      end
    end

    if plugin_path == nil then
      utils.notify('Could not find the plugin directory for LazyLanguages.nvim', { level = vim.log.levels.ERROR })
      return
    end

    local file_path = plugin_path .. ('/lua/LazyLanguages/languages/'):gsub('/', utils.path_separator) .. language .. '.lua'
    local file_handle = io.open(file_path, 'r')
    if file_handle == nil then
      utils.notify("There was an error opening the file for '" .. language .. "'", { level = vim.log.levels.ERROR })
      return
    end
    local file_content = file_handle:read '*a'
    file_handle:close()

    local override_path = vim.fn.stdpath 'config'
      .. utils.path_separator
      .. 'lua'
      .. utils.path_separator
      .. vim.g.lazylangs.override_path:gsub('%.', utils.path_separator)

    if not vim.uv.fs_stat(override_path) then
      if not vim.fn.mkdir(override_path, 'p') then
        utils.notify("There was an error creating directory'" .. override_path .. "'", { level = vim.log.levels.ERROR })
        return
      end
    end
    local dump_file_path = override_path .. utils.path_separator .. language .. '.lua'
    if vim.uv.fs_stat(dump_file_path) then
      if vim.fn.confirm(dump_file_path .. ' already exists, do you want to override it?', '&Yes\n&No', 2, 'Question') ~= 1 then
        utils.notify 'Aborting config dump'
        return
      end
    end
    local dump_file = io.open(dump_file_path, 'w')
    if dump_file == nil then
      utils.notify("There was an error opening '" .. dump_file_path .. "' to write out the config", { level = vim.log.levels.ERROR })
      return
    end
    dump_file:write(file_content)
    dump_file:close()
  end, { nargs = 1 })
end

return setmetatable(M, {
  __index = function(_, k)
    return config[k]
  end,
})
