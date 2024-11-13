---@type ll.Language
return {
  plugins = {
    {
      'MeanderingProgrammer/render-markdown.nvim',
      dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
      ---@module 'render-markdown'
      ---@type render.md.UserConfig
      opts = {
        enabled = false,
        preset = 'obsidian',
      },
      config = function(_, opts)
        require('render-markdown').setup(opts)
        vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWinEnter' }, {
          group = vim.api.nvim_create_augroup('LazyLanguages', { clear = false }),
          pattern = { 'markdown' },
          command = 'RenderMarkdown',
        })
      end,
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
