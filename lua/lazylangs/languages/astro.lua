---@module "lazylangs"
---@type ll.Language
local M = {
  lsp = {
    name = 'astro',
    server_configuration = {},
  },
  mason_packages = {
    'astro-language-server',
  },
}

return M
