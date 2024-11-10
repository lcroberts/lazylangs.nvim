local lang_helpers = require 'LazyLanguages.lang_helpers'
---@type ll.Config
local config = require 'LazyLanguages.config'

local M = {}

-- Extract plugin tables for every language and insert it into returned table
for _, language in ipairs(config.languages) do
  local language_table = lang_helpers.get_language_table(language)

  -- Add plugins to returned plugin list
  if language_table.plugins ~= nil then
    table.insert(M, language_table.plugins or {})
  end
end

return M
