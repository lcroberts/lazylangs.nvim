---@module "lazylangs"
---@type ll.Language
return {
  plugins = {},
  lsp = {
    name = 'glsl_analyzer',
    server_configuration = {},
  },
  mason_packages = {
    'glsl_analyzer',
  },
}
