local M = {}

if vim.fn.has 'win32' == 1 or vim.fn.has 'win64' == 1 then
  M.path_separator = '\\'
else
  M.path_separator = '/'
end

return M
