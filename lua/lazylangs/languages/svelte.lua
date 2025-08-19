---@module "lazylangs"
---@type ll.Language
local M = {
  lsp = {
    name = 'svelte',
    server_configuration = {},
  },
  mason_packages = {
    'svelte-language-server',
  },
}

return M
