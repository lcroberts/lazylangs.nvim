---@module "lazylangs"
---@type ll.Language
return {
  lsp = {
    name = 'intelephense',
    server_configuration = {},
  },
  linters = {
    nvim_lint = {
      php = { 'phpstan' },
    },
  },
  formatters = {
    conform = {
      php = { 'pint' },
    },
  },
  mason_packages = {
    'intelephense',
    'phpstan',
    'pint',
    'php-debug-adapter',
  },
  setup = function()
    local dap = require 'dap'
    local paths = require 'lazylangs.helpers.paths'
    dap.adapters.php = {
      type = 'executable',
      command = paths.mason_bin_path 'php-debug-adapter',
      args = {},
    }
    dap.configurations.php = {
      {
        type = 'php',
        request = 'launch',
        name = 'Listen for Xdebug',
        port = 9003,
      },
    }
  end,
}
