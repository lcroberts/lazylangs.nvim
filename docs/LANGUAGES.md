# Language Configuration Details

## Table of Contents:

- [Go](#Go)

## Go

- LSP: gopls
- Formatter: LSP Builtin (gofmt)
- Additional plugins:
```lua
{
    {
      'ray-x/go.nvim',
      dependencies = { -- optional packages
        'ray-x/guihua.lua',
        'neovim/nvim-lspconfig',
        'nvim-treesitter/nvim-treesitter',
      },
      config = function()
        require('go').setup()
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
  }
```
