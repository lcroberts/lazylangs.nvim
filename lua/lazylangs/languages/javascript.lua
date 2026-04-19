vim.pack.add { 'https://github.com/pmizio/typescript-tools.nvim' }

require('lazylangs.helpers.lazy').by_ft(
  { 'javascript', 'javascriptreact', 'javascript.jsx', 'typescript', 'typescriptreact', 'typescript.tsx', 'svelte' },
  function()
    require('typescript-tools').setup {
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
    }
  end
)

---@module "lazylangs"
---@type ll.Language
local M = {
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
