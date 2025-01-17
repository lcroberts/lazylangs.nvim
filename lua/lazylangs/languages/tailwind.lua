--- @module "lazylangs"
--- @type ll.Language
return {
  lsp = {
    {
      name = 'tailwindcss',
      server_configuration = {},
    },
    {
      name = 'cssls',
      server_configuration = {},
    },
  },
  mason_packages = {
    'css-lsp',
    'tailwindcss-language-server',
  },
}
