---@type ll.Language
return {
  plugins = {
    {
      'folke/lazydev.nvim',
      ft = 'lua',
      dependencies = {
        { 'Bilal2453/luvit-meta', lazy = true },
      },
      opts = {
        library = {
          { path = 'luvit-meta/library', words = { 'vim%.uv' } },
        },
      },
    },
    {
      'hrsh7th/nvim-cmp',
      opts = function(_, opts)
        opts.sources = opts.sources or {}
        table.insert(opts.sources, {
          name = 'lazydev',
          group_index = 0, -- set group index to 0 to skip loading LuaLS completions
        })
      end,
    },
  },
  lsp = {
    name = 'lua_ls',
    server_configuration = {
      -- cmd = {...},
      -- filetypes = { ...},
      -- capabilities = {},
      settings = {
        Lua = {
          completion = {
            callSnippet = 'Replace',
          },
          -- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
          diagnostics = { disable = { 'missing-fields' } },
          hint = { enable = true },
        },
      },
    },
  },
  -- Should be in the form conform expects for formatters_by_ft
  formatters = {
    'stylua',
  },
  mason_packages = {
    'lua_ls',
    'stylua',
  },
}
