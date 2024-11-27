---@module "LazyLanguages"
---@type ll.Language
return {
  plugins = {
    {
      'mrcjkb/rustaceanvim',
      version = '^5', -- Recommended
      lazy = false, -- This plugin is already lazy
      config = function()
        vim.g.rustaceanvim = {
          -- Plugin configuration
          tools = {},
          -- LSP configuration
          server = {
            on_attach = require('LazyLanguages.config').lsp.on_attach, -- Config should be loaded by the time this is ran
          },
          -- DAP configuration
          dap = {}, -- TODO: Fix debug info not being encoded without manual compilation
        }
      end,
    },
  },
  mason_packages = {
    'rust-analyzer',
    'codelldb',
  },
}
