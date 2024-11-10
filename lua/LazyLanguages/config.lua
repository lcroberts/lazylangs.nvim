local utils = require 'LazyLanguages.utils'
local M = {}

--- @class ll.Config
local config = {
  ---Are mason packages for languages automatically installed
  ---@type boolean
  mason_install = false,
  ---Are mason packages for languages automatically updated
  ---@type boolean
  mason_update = false,
}

---@param opts? ll.Config
M.setup = function(opts)
  opts = opts or {}
  config = vim.tbl_deep_extend('keep', opts, config)

  require('LazyLanguages.lang_helpers').language_setup()
end

return setmetatable(M, {
  __index = function(_, k)
    return config[k]
  end,
})
