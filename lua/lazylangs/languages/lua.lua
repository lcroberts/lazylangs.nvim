vim.pack.add {
  'https://github.com/folke/lazydev.nvim',
}

require('lazylangs.helpers.lazy').by_ft({ 'lua' }, function()
  require('lazydev').setup {
    library = {
      -- See the configuration section for more details
      -- Load luvit types when the `vim.uv` word is found
      { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
    },
  }
end)

---@module "lazylangs"
---@type ll.Language
return {
  lsp = {
    name = 'lua_ls',
    server_configuration = {
      -- cmd = {...},
      -- filetypes = { ...},
      -- capabilities = {},
      settings = {
        Lua = {
          hint = { enable = true },
        },
      },
    },
  },
  formatters = {
    conform = {
      lua = {
        'stylua',
      },
    },
  },
  mason_packages = {
    'lua-language-server',
    'stylua',
  },
}
