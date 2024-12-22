---@module "lazylangs"
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
    conform = {
      bash = {
        'shfmt'
      },
    }
  },
  linters = {
    nvim_lint = {
      bash = { 'shellcheck' },
    },
  },
}
