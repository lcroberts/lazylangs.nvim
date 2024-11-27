---@module "LazyLanguages"
---@type ll.Language
return {
  lsp = {
    name = 'bashls',
    server_configuration = {},
  },
  mason_packages = {
    'bash-language-server',
    'shfmt',
  },
  formatters = { 'shfmt' },
}
