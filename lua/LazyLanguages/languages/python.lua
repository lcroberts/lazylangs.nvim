local utils = require 'LazyLanguages.utils'
---@type ll.Language
return {
  plugins = {
    {
      'mfussenegger/nvim-dap-python',
      config = function()
        require('dap-python').setup(vim.fn.stdpath 'data' .. utils.path_separator .. ('mason/packages/debugpy/venv/bin/python'):gsub('/', utils.path_separator))
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
