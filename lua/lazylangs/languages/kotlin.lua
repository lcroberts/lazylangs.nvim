---@module "lazylangs"
---@type ll.Language
return {
  lsp = {
    name = 'kotlin_lsp',
    server_configuration = {},
  },
  mason_packages = {
    'kotlin-lsp',
  },
}
