local config = require 'LazyLanguages.config'

local plugins = {
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
}

local cmp = {
  'hrsh7th/nvim-cmp',
  opts = function(_, opts)
    opts.sources = opts.sources or {}
    table.insert(opts.sources, {
      name = 'lazydev',
      group_index = 0, -- set group index to 0 to skip loading LuaLS completions
    })
  end,
}

local blink = {
  'saghen/blink.cmp',
  opts = function(_, opts)
    table.insert(opts.sources.completion.enabled_providers, 'lazydev')
    if opts.sources.providers.lsp == nil then
      opts.sources.providers.lsp = { fallback_for = { 'lazydev' } }
    else
      opts.sources.providers.lsp.fallback_for = { 'lazydev' }
    end
    opts.sources.providers.lazydev = { name = 'LazyDev', module = 'lazydev.integrations.blink' }
  end,
}

if config.completion.plugin == 'nvim-cmp' then
  table.insert(plugins, cmp)
elseif config.completion.plugin == 'blink.cmp' then
  table.insert(plugins, blink)
end

---@module "LazyLanguages"
---@type ll.Language
return {
  plugins = plugins,
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
          diagnostics = { disable = { 'missing-fields' } },
          hint = { enable = true },
        },
      },
    },
  },
  formatters = {
    conform = {
      'stylua',
    },
  },
  mason_packages = {
    'lua-language-server',
    'stylua',
  },
}
