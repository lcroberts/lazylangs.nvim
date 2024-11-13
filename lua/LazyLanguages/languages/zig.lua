---@type ll.Language
return {
  plugins = {},
  lsp = {
    name = 'zls',
    server_configuration = {},
  },
  mason_packages = {
    'zls',
    'codelldb',
  },
  setup = function()
    local dap = require 'dap'
    dap.adapters.codelldb = {
      type = 'server',
      port = '${port}',
      executable = {
        command = require('LazyLanguages.utils').mason_bin_path 'codelldb',
        args = { '--port', '${port}' },
        -- On windows you may have to uncomment this:
        -- detached = false,
      },
    }
    dap.configurations.zig = {
      {
        name = 'Launch file',
        type = 'codelldb',
        request = 'launch',
        program = function()
          return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
        end,
        args = function()
          local args_string = vim.fn.input 'Arguments: '
          return vim.split(args_string, ' ')
        end,
        cwd = '${workspaceFolder}',
        stopOnEntry = false,
      },
    }
  end,
}
