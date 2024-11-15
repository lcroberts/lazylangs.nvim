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
    local dap = require 'dap'
    local dap_helpers = require 'LazyLanguages.helpers.dap'
    dap.adapters.zig = dap_helpers.codelldb_adapter_config
    dap.configurations.zig = dap_helpers.simple_codelldb_launch_config 'zig'
  end,
}
