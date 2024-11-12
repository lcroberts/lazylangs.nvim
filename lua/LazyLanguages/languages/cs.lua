---@type ll.Language
return {
  lsp = {
    name = 'omnisharp',
    server_configuration = {
      cmd = { vim.fn.stdpath 'data' .. ('/mason/bin/omnisharp'):gsub('/', require('LazyLanguages.utils').path_separator) },
    },
  },
  mason_packages = {
    'omnisharp',
    'netcoredbg',
  },
  setup = function()
    local dap = require 'dap'

    dap.adapters.coreclr = {
      type = 'executable',
      command = vim.fn.stdpath 'data' .. ('/mason/bin/netcoredbg'):gsub('/', require('LazyLanguages.utils').path_separator),
      args = { '--interpreter=vscode' },
    }

    dap.configurations.cs = {
      {
        type = 'coreclr',
        name = 'launch - netcoredbg',
        request = 'launch',
        program = function()
          return vim.fn.input('Path to dll', vim.fn.getcwd() .. '/bin/Debug/', 'file')
        end,
        args = function()
          local args_string = vim.fn.input 'Arguments: '
          return vim.split(args_string, ' ')
        end,
      },
    }
  end,
}
