---@module "lazylangs"
---@type ll.Language
return {
  lsp = {
    {
      name = 'emmet_ls',
      server_configuration = {},
    },
    {
      name = 'html',
      server_configuration = {},
    },
  },
  mason_packages = {
    'emmet-ls',
    'html-lsp',
  },
}
