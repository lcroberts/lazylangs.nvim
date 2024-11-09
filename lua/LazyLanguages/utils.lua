local M = {}

if vim.fn.has 'win32' == 1 or vim.fn.has 'win64' == 1 then
  M.path_separator = '\\'
else
  M.path_separator = '/'
end

---Returns whether a file exists or not
---@param file_path string
---@return boolean
M.file_exists = function(file_path)
  local f = io.open(file_path, 'r')
  if f ~= nil then
    f:close()
    return true
  else
    return false
  end
end

---@alias NotifyOpts {level?: number, once?: boolean}

---Sends a vim notify message with provided options
---@param message string | string[]
---@param opts? NotifyOpts
M.notify = function(message, opts)
  opts = opts or {}
  message = type(message) == 'table' and table.concat(opts, '\n') or message
  message = 'LazyLanguages.nvim: ' .. message
  ---@cast message string
  message = vim.trim(message)
  return vim[opts.once and 'notify_once' or 'notify'](message, opts.level or vim.log.levels.INFO)
end

return M
