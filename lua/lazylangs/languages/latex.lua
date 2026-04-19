vim.pack.add { 'https://github.com/lervag/vimtex' }
vim.g.vimtex_view_method = 'zathura'

---@module "lazylangs"
---@type ll.Language
return {
  lsp = {
    name = 'texlab',
    server_configuration = {},
  },
  mason_packages = {
    'texlab',
  },
}
