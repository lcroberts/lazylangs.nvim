---@module "lazylangs"
---@type ll.Language
return {
  plugins = {
    {
      'ray-x/go.nvim',
      dependencies = { -- optional packages
        'ray-x/guihua.lua',
        'neovim/nvim-lspconfig',
        'nvim-treesitter/nvim-treesitter',
      },
      config = function()
        require('lazylangs.languages.go').setup()
      end,
      event = { 'CmdlineEnter' },
      ft = { 'go', 'gomod', 'gowork', 'gotmpl' },
      build = ':lua require("go.install").update_all_sync()', -- if you need to install/update all binaries
    },
    {
      'leoluz/nvim-dap-go',
      ft = { 'go', 'gomod', 'gowork', 'gotmpl' },
      dependencies = {
        'mfussenegger/nvim-dap',
      },
      opts = {},
    },
  },
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
