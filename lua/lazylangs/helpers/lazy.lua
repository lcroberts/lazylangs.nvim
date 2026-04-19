local M = {}

---Lazily execute a function by autocmd
---@param filetypes string[]
---@param callback function
M.by_ft = function(filetypes, callback)
  vim.api.nvim_create_autocmd('FileType', {
    pattern = filetypes,
    callback = callback,
  })
end

return M
