local lang_helpers = require 'LazyLanguages.lang_helpers'

local M = {}

-- Extract plugin tables for every language and insert it into returned table
for _, language in ipairs(vim.g.lazylangs.langs) do
  local language_table = lang_helpers.get_language_table(language)
  if language_table == nil then
    goto continue
  end

  -- Add plugins to returned plugin list
  if language_table.plugins ~= nil then
    table.insert(M, language_table.plugins or {})
  end
  ::continue::
end

return M
