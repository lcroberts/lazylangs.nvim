local utils = require 'LazyLanguages.utils'
---@type ll.Language
return {
  plugins = {
    {
      'mfussenegger/nvim-dap-python',
      config = function()
        require('dap-python').setup(require('LazyLanguages.utils').mason_package_path 'debugpy' .. ('/venv/bin/python'):gsub('/', utils.path_separator))
      end,
    },
  },
  lsp = {
    name = 'pyright',
    server_configuration = {},
  },
  mason_packages = {
    'pyright',
    'isort',
    'black',
    'debugpy',
  },
  formatters = { 'isort', 'black' },
}
