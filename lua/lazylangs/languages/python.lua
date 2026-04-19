---@module "lazylangs"
local path_helpers = require 'lazylangs.helpers.paths'
vim.pack.add { 'https://github.com/mfussenegger/nvim-dap-python' }

require('lazylangs.helpers.lazy').by_ft({ 'python' }, function()
  require('dap-python').setup(path_helpers.mason_package_path 'debugpy' .. ('/venv/bin/python'):gsub('/', path_helpers.path_separator))
end)

---@type ll.Language
return {
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
    conform = {
      python = { 'isort', 'black' },
    },
  },
}
