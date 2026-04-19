---@module "lazylangs"
vim.pack.add { 'https://github.com/suketa/nvim-dap-ruby' }

require('lazylangs.helpers.lazy').by_ft({ 'ruby' }, function()
  require('dap-ruby').setup()
end)

---@type ll.Language
return {
  lsp = {
    name = 'solargraph',
    server_configuration = {},
  },
  mason_packages = {
    'solargraph',
  },
}
