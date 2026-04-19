---@module "lazylangs"
---@type ll.Language
return {
  lsp = {
    name = 'wgsl_analyzer',
    server_configuration = {},
  },
  mason_packages = {
    'wgsl-analyzer',
  },
}
