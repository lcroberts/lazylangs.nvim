---@module "lazylangs"
---@type ll.Language
return {
  lsp = {
    name = 'fsautocomplete',
    server_configuration = {},
  },
  mason_packages = {
    'fsautocomplete',
    'fantomas',
    'netcoredbg',
  },
  setup = function()
    local debugging_plugin = vim.g.lazylangs.debugging_plugin or nil
    if debugging_plugin == 'nvim-dap' then
      local dap = require 'dap'

      dap.adapters.fsharp = {
        type = 'executable',
        command = require('lazylangs.helpers.paths').mason_bin_path 'netcoredbg',
        args = { '--interpreter=vscode' },
      }

      dap.configurations.fsharp = {
        {
          type = 'fsharp',
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
    end
  end,
}
