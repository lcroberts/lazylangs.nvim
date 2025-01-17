---@module "lazylangs"
---@type ll.Language
return {
  lsp = {
    {
      name = 'cssls',
      server_configuration = {},
    },
  },
  mason_packages = {
    'css-lsp',
  },
}
