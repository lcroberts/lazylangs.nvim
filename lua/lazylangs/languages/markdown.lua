---@module "lazylangs"
---@type ll.Language
return {
  plugins = {
    {
      'MeanderingProgrammer/render-markdown.nvim',
      ft = 'markdown',
      dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
      ---@module 'render-markdown'
      ---@type render.md.UserConfig
      opts = {
        enabled = true,
        preset = 'obsidian',
      },
    },
  },
  lsp = {
    name = 'marksman',
    server_configuration = {},
  },
  mason_packages = {
    'marksman',
  },
}
