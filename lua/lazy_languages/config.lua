local M = {}

local config = {}

---@param opts table
M.setup = function(opts)
  opts = opts or {}
  config = vim.tbl_deep_extend('keep', opts, config)
end

return setmetatable(M, {
  __index = function(_, k)
    return config[k]
  end,
})
