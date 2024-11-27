---@module "LazyLanguages"
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
    },
  },
  lsp = {
    name = 'marksman',
    server_configuration = {},
  },
  mason_packages = {
    'marksman',
  },
  setup = function()
    vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWinEnter' }, {
      group = vim.api.nvim_create_augroup('LLRenderMarkdown', { clear = true }),
      pattern = { 'markdown' },
      command = 'RenderMarkdown',
    })
  end,
}
