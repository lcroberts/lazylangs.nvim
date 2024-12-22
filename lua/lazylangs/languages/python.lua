local path_helpers = require 'lazylangs.helpers.paths'
---@module "lazylangs"
---@type ll.Language
return {
  plugins = {
    {
      'mfussenegger/nvim-dap-python',
      config = function()
        require('dap-python').setup(path_helpers.mason_package_path 'debugpy' ..
          ('/venv/bin/python'):gsub('/', path_helpers.path_separator))
      end,
    },
  },
  lsp = {
    name = 'basedpyright',
    server_configuration = {
      settings = {
        basedpyright = {
          -- Without this there are a lot of unnecessary warnings, some may want this to not be here though.
          typeCheckingMode = 'standard',
        },
      },
    },
  },
  mason_packages = {
    'basedpyright',
    'isort',
    'black',
    'debugpy',
  },
  formatters = {
    conform = { 'isort', 'black' },
  },
}
