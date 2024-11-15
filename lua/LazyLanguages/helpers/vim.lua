local M = {}

---@param message string|string[]
---@param level? integer
M.notify = function(message, level)
  if type(message) == 'table' then
    message = table.concat(message, '\n')
    message = 'LazyLanguages:\n' .. message
  else
    message = 'LazyLanguages: ' .. message
  end
  level = level or vim.log.levels.INFO
  vim.notify(message, level, { title = 'LazyLanguages' })
end

---@param message string|string[]
---@param level? integer
M.notify_once = function(message, level)
  if type(message) == 'table' then
    message = table.concat(message, '\n')
    message = 'LazyLanguages:\n' .. message
  else
    message = 'LazyLanguages: ' .. message
  end
  level = level or vim.log.levels.INFO
  vim.notify_once(message, level, { title = 'LazyLanguages' })
end

return M
