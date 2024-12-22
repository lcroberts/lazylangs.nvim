---@module "lazylangs"
---@type ll.Language
return {
  lsp = {
    name = 'ols',
    server_configuration = {},
  },
  mason_packages = {
    'ols',
    'codelldb',
  },
  setup = function()
    local dap = require 'dap'
    local dap_helpers = require 'lazylangs.helpers.dap'
    dap.adapters.odin = dap_helpers.codelldb_adapter_config
    dap.configurations.odin = dap_helpers.simple_codelldb_launch_config 'odin'
  end,
}
