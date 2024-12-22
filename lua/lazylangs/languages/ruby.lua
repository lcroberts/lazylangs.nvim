---@module "lazylangs"
---@type ll.Language
return {
  plugins = {
    {
      'suketa/nvim-dap-ruby',
      dependencies = { 'mfussenegger/nvim-dap' },
      opts = {},
    },
  },
  lsp = {
    name = 'solargraph',
    server_configuration = {},
  },
  mason_packages = {
    'solargraph',
  },
}
