---@module "lazylangs"
---@type ll.Language
return {
  plugins = {},
  lsp = {
    name = 'kotlin_language_server',
    server_configuration = {},
  },
  mason_packages = {
    'kotlin-language-server',
  },
}
