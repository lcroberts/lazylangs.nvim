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
  opts = {
    sources = {
      default = { 'lazydev' },
      providers = {
        lazydev = {
          name = 'LazyDev',
          module = 'lazydev.integrations.blink',
          score_offset = 100,
        },
      },
    },
  },
  opts_extend = { 'sources' },
}

local completion_plugin = vim.g.lazylangs.completion_plugin or 'nvim-cmp'
if completion_plugin == 'nvim-cmp' then
  table.insert(plugins, cmp)
elseif completion_plugin == 'blink.cmp' then
  table.insert(plugins, blink)
end

---@module "lazylangs"
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
