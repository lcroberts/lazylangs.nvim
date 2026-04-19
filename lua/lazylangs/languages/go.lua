---@module "lazylangs"
vim.pack.add {
  'https://github.com/ray-x/go.nvim',
  'https://github.com/ray-x/guihua.lua',
  'https://github.com/leoluz/nvim-dap-go',
}

require('lazylangs.helpers.lazy').by_ft({ 'go', 'gomod', 'gowork', 'gotmpl' }, function()
  require('go').setup()
  require('dap-go').setup {}
end)

---@type ll.Language
return {
  lsp = {
    name = 'gopls',
    server_configuration = {
      settings = {
        gopls = {
          hints = {
            rangeVariableTypes = true,
            parameterNames = true,
            constantValues = true,
            assignVariableTypes = true,
            compositeLiteralFields = true,
            compositeLiteralTypes = true,
            functionTypeParameters = true,
          },
        },
      },
    },
  },
  mason_packages = {
    'gopls',
    'delve',
  },
}
