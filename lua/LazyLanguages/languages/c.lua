---@type ll.Language
return {
  plugins = {
    {
      'p00f/clangd_extensions.nvim',
      ft = { 'c', 'cpp', 'objc', 'objcpp', 'cuda', 'proto' },
      opts = {},
    },
  },
  lsp = {
    name = 'clangd',
    server_configuration = {
      capabilities = {
        offsetEncoding = 'utf-8',
      },
    },
  },
  mason_packages = {
    'clangd',
    'codelldb',
  },
  setup = function()
    local dap = require 'dap'
    local dap_helpers = require 'LazyLanguages.helpers.dap'

    dap.adapters.cpp = dap_helpers.codelldb_adapter_config
    dap.configurations.cpp = dap_helpers.simple_codelldb_launch_config 'cpp'

    dap.adapters.c = dap_helpers.codelldb_adapter_config
    dap.configurations.c = dap_helpers.simple_codelldb_launch_config 'c'
  end,
}
