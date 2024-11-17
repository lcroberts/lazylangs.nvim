local path_helpers = require 'LazyLanguages.helpers.paths'
---@type ll.Language
return {
  plugins = {
    {
      'mfussenegger/nvim-dap-python',
      config = function()
        require('dap-python').setup(path_helpers.mason_package_path 'debugpy' .. ('/venv/bin/python'):gsub('/', path_helpers.path_separator))
      end,
    },
  },
  lsp = {
    name = 'basedpyright',
    server_configuration = {},
  },
  mason_packages = {
    'basedpyright',
    'isort',
    'black',
    'debugpy',
  },
  formatters = { 'isort', 'black' },
}
