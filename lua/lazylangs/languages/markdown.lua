---@module "lazylangs"
local filetypes = { 'markdown', 'markdown.mdx', 'mdx' }
vim.pack.add { 'https://github.com/MeanderingProgrammer/render-markdown.nvim' }

require('lazylangs.helpers.lazy').by_ft(filetypes, function()
  require('render-markdown').setup {
    enabled = true,
    preset = 'obsidian',
  }
end)

---@type ll.Language
return {
  lsp = {
    name = 'marksman',
    server_configuration = {
      filetypes = filetypes,
    },
  },
  mason_packages = {
    'marksman',
  },
}
