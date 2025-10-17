---@module "lazylangs"
---@type ll.Language
return {
  plugins = {},
  lsp = {
    name = 'kotlin_lsp',
    server_configuration = {},
  },
  mason_packages = {
    'kotlin-lsp',
  },
}
