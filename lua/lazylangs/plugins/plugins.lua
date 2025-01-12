local lang_helpers = require 'lazylangs.langs'

local M = {}

-- Extract plugin tables for every language and insert it into returned table
if vim.g.lazylangs.langs ~= nil then
  for _, language in ipairs(vim.g.lazylangs.langs) do
    local language_table = lang_helpers.language_tables[language]
    if language_table == nil then
      goto continue
    end

    -- Add plugins to returned plugin list
    if language_table.plugins ~= nil then
      table.insert(M, language_table.plugins or {})
    end
    ::continue::
  end
else
  require('lazylangs.helpers.vim').notify_once(
    'vim.g.lazylangs.langs is not set so no languages will be loaded. If you this is intentional try setting it to an empty table.',
    vim.log.levels.WARN
  )
end

return M
