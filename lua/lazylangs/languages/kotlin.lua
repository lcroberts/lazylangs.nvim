---@module "lazylangs"
---@type ll.Language
return {
  plugins = {},
  lsp = {
    name = 'kotlin-language-server',
    server_configuration = {},
  },
  mason_packages = {
    'kotlin-language-server',
  },
}
