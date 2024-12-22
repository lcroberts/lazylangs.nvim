local M = {}

---@param message string|string[]
---@param level? integer
M.notify = function(message, level)
  if type(message) == 'table' then
    message = table.concat(message, '\n')
    message = 'lazylangs:\n' .. message
  else
    message = 'lazylangs: ' .. message
  end
  level = level or vim.log.levels.INFO
  vim.notify(message, level, { title = 'lazylangs' })
end

---@param message string|string[]
---@param level? integer
M.notify_once = function(message, level)
  if type(message) == 'table' then
    message = table.concat(message, '\n')
    message = 'lazylangs:\n' .. message
  else
    message = 'lazylangs: ' .. message
  end
  level = level or vim.log.levels.INFO
  vim.notify_once(message, level, { title = 'lazylangs' })
end

return M
