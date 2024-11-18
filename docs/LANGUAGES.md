# Language Configuration Details

## Table of Contents:

- [Go](#Go)
- [Java](#Java)

## [Go](https://github.com/lcroberts/LazyLanguages.nvim/blob/main/lua/LazyLanguages/languages/go.lua)

- LSP: gopls
- Formatter: LSP Builtin (gofmt)
- Additional plugins:
```lua
{
    {
      'ray-x/go.nvim',
      dependencies = {
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

## [Java](https://github.com/lcroberts/LazyLanguages.nvim/blob/main/lua/LazyLanguages/languages/java.lua)

- LSP: jdtls
- Formatter: LSP Builtin (jdtls)
- Additional Plugins:
```lua
{
    {
      'mfussenegger/nvim-jdtls',
      config = function()
        local opts = {
          cmd = { vim.fn.stdpath 'data' .. ('/mason/bin/jdtls'):gsub('/', require('LazyLanguages.helpers.paths').path_separator) },
          settings = {
            java = {
              inlayHints = {
                parameterNames = {
                  enabled = 'all',
                  exclusions = { 'this' },
                },
              },
            },
          },
          root_dir = vim.fs.dirname(vim.fs.find({ 'gradlew', '.git', 'mvnw' }, { upward = true })[1]),
          init_options = {
            bundles = {
              vim.fn.glob(
                vim.fn.stdpath 'data'
                  .. ('/mason/packages/java-debug-adapter/extension/server/com.microsoft.java.debug.plugin-*.jar'):gsub(
                    '/',
                    require('LazyLanguages.helpers.paths').path_separator
                  ),
                true
              ),
            },
          },
        }
        vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWinEnter' }, {
          group = vim.api.nvim_create_augroup('LLJdtls', { clear = true }),
          pattern = '*.java',
          callback = function()
            require('jdtls').start_or_attach(opts)
          end,
        })
      end,
    },
  }
```
