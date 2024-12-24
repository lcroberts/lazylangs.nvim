# Installation

## Requirements

- The plugin is tested only on the latest stable version of neovim.
- [lazy.nvim](https://github.com/folke/lazy.nvim)
- [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig)
- Optional:
  - A completion plugin: [nvim-cmp](https://github.com/hrsh7th/nvim-cmp) or [blink.cmp](https://github.com/Saghen/blink.cmp)
  - [nvim-dap](https://github.com/mfussenegger/nvim-dap)
  - [conform.nvim](https://github.com/stevearc/conform.nvim)
  - [nvim-lint](https://github.com/mfussenegger/nvim-lint)

## Setting Up The Globals

Some of the configuration is required to be put into a global variable since
some amount of state needs to be known at the time lazy.nvim loads the plugins
which is done before the setup function of the plugin is called.

```lua
vim.g.lazylangs = {
  -- '.' separated path relative to the lua directory in this case from
  -- the neovim config directory it's 'lua/languages'. 'foo.bar' would
  -- make the path 'lua/foo/bar'
  ---@type string
  override_path = 'languages',
  ---List of strings of language names/aliases. See Language Support.
  ---@type string[]
  langs = { "lua", "markdown", "python" },
  ---Optional completion engine plugin to be used
  ---@type "nvim-cmp"|"blink.cmp"
  completion_plugin = "nvim-cmp",
  ---Optional formatting plugin is used.
  ---@type "conform"
  formatting_plugin = 'conform',
  ---Optional linting plugin to be used
  ---@type "nvim-lint"
  linting_plugin = 'nvim-lint',
}
```

For more tips see the [recipes](./recipes).

## Lazy

```lua
{
  'lcroberts/lazylangs.nvim',
  event = 'VeryLazy',
  dependencies = {
    'neovim/nvim-lspconfig',
    'mfussenegger/nvim-dap',
    -- Optional
    'williamboman/mason.nvim',
    'stevearc/conform.nvim',
    'hrsh7th/nvim-cmp', -- If using blink.cmp put that here
    'mfussenegger/nvim-lint',
  },
  ---@module 'lazylangs'
  ---@type ll.Config
  opts = {}, -- Setup options go here
  import = 'lazylangs.plugins', -- Imports plugins from the language configurations
}
```
