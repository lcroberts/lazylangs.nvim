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

--- Returns a path to a mason binary
---@param bin_name any
---@return unknown
M.mason_bin_path = function(bin_name)
  return vim.fn.stdpath 'data' .. ('/mason/bin/'):gsub('/', M.path_separator) .. bin_name
end

--- Returns a path to a mason package directory
---@param package_name any
---@return unknown
M.mason_package_path = function(package_name)
  return vim.fn.stdpath 'data' .. ('/mason/package/'):gsub('/', M.path_separator) .. package_name .. M.path_separator
end

return M
