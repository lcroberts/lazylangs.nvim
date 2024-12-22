---@module "lazylangs"
---@type ll.Language
return {
  plugins = {
    {
      'lervag/vimtex',
      lazy = false, -- we don't want to lazy load VimTeX
      -- tag = "v2.15", -- uncomment to pin to a specific release
      init = function()
        -- VimTeX configuration goes here, e.g.
        vim.g.vimtex_view_method = 'zathura'
      end,
    },
  },
  lsp = {
    name = 'texlab',
    server_configuration = {},
  },
  mason_packages = {
    'texlab',
  },
}
