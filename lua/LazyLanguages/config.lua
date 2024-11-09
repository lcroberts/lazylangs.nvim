local utils = require 'LazyLanguages.utils'
local M = {}

--- @class ll.Config
local config = {
  ---Language module override path relative to your neovim config directory
  ---@type string
  override_path = 'lua.languages',

  ---List of language configurations to be automatically loaded.
  ---@type table
  languages = { 'lua' },

  ---Path to a file that returns a table of language configurations to be
  ---loaded. It is merged with the languages option. This is a module style
  ---path relative to the config directory
  ---@type string | nil
  languages_file = nil,

  -- TODO: Figure out correct order for these
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

  -- Merge languages and languages in language_file without duplication
  local enabled_langs = {}
  for _, language in ipairs(config.languages) do
    enabled_langs[language] = true
  end
  if config.languages_file ~= nil then
    local path = vim.fn.stdpath 'config'
    local languages_file = path ..
        utils.path_separator .. config.languages_file:gsub('%.', utils.path_separator) .. '.lua'
    if utils.file_exists(languages_file) then
      for _, language in ipairs(dofile(languages_file)) do
        enabled_langs[language] = true
      end
    else
      utils.notify("The override file at '" .. languages_file .. "' does not exists", { level = vim.log.levels.WARN })
    end
  end
  config.languages = vim.tbl_keys(enabled_langs)
end

return setmetatable(M, {
  __index = function(_, k)
    return config[k]
  end,
})
