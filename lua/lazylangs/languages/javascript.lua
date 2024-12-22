---@module "lazylangs"
---@type ll.Language
local M = {
  plugins = {
    {
      'pmizio/typescript-tools.nvim',
      ft = { 'javascript', 'javascriptreact', 'javascript.jsx', 'typescript', 'typescriptreact', 'typescript.tsx' },
      dependencies = { 'nvim-lua/plenary.nvim', 'neovim/nvim-lspconfig' },
      opts = {
        settings = {
          tsserver_file_preferences = {
            includeInlayParameterNameHints = 'all',
            includeInlayParameterNameHintsWhenArgumentMatchesName = false,
            includeInlayFunctionParameterTypeHints = true,
            includeInlayVariableTypeHints = true,
            includeInlayVariableTypeHintsWhenTypeMatchesName = false,
            includeInlayPropertyDeclarationTypeHints = true,
            includeInlayFunctionLikeReturnTypeHints = true,
            includeInlayEnumMemberValueHints = true,
          },
        },
      },
    },
  },
  mason_packages = {
    'typescript-language-server',
    'prettierd',
  },
  formatters = {
    conform = {
      javascript = {
        'prettierd',
        'prettier',
        stop_after_first = true,
      },
    },
  },
}

M.formatters.conform.typescript = M.formatters.conform.javascript

return M
