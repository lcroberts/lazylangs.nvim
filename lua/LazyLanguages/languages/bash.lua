---@type ll.Language
return {
  lsp = {
    name = 'bashls',
    server_configuration = {},
  },
  mason_packages = {
    'bashls',
    'shfmt',
  },
  formatters = { 'shfmt' },
}
