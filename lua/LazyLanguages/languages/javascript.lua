---@type ll.Language
return {
  plugins = {
    {
      'pmizio/typescript-tools.nvim',
      ft = { 'javascript', 'javascriptreact', 'javascript.jsx', 'typescript', 'typescriptreact', 'typescript.tsx' },
      dependencies = { 'nvim-lua/plenary.nvim', 'neovim/nvim-lspconfig' },
      opts = {},
    },
  },
  mason_packages = {
    'tsserver',
    'prettierd',
  },
  formatters = {
    'prettierd',
    'prettier',
    stop_after_first = true,
  },
}
