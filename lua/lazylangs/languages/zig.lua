---@module "lazylangs"
---@type ll.Language
return {
  plugins = {},
  lsp = {
    name = 'zls',
    server_configuration = {},
  },
  mason_packages = {
    'zls',
    'codelldb',
  },
  setup = function()
    local debugging_plugin = vim.g.lazylangs.debugging_plugin or nil
    if debugging_plugin == 'nvim-dap' then
      local dap = require 'dap'
      local dap_helpers = require 'lazylangs.helpers.dap'
      dap.adapters.zig = dap_helpers.codelldb_adapter_config
      dap.configurations.zig = dap_helpers.simple_codelldb_launch_config 'zig'
    end
  end,
}
