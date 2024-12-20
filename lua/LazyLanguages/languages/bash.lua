---@module "LazyLanguages"
---@type ll.Language
return {
  lsp = {
    name = 'bashls',
    server_configuration = {},
  },
  mason_packages = {
    'bash-language-server',
    'shfmt',
    'shellcheck',
  },
  formatters = {
    conform = { 'shfmt' },
  },
  linters = {
    nvim_lint = {
      bash = { 'shellcheck' },
    },
  },
}
