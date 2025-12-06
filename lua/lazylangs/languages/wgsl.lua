---@module "lazylangs"
---@type ll.Language
return {
  plugins = {},
  lsp = {
    name = 'wgsl_analyzer',
    server_configuration = {},
  },
  mason_packages = {
    'wgsl-analyzer',
  },
}
