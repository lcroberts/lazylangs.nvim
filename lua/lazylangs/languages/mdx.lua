---@module "lazylangs"
---@type ll.Language
return {
  lsp = {
    name = 'mdx_analyzer',
    server_configuration = {},
  },
  mason_packages = {
    'mdx-analyzer',
  },
  setup = function()
    vim.filetype.add {
      extension = {
        mdx = 'mdx',
      },
    }
    vim.treesitter.language.register('markdown', 'mdx')
  end,
}
