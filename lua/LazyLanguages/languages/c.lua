---@type ll.Language
return {
  plugins = {
    {
      'p00f/clangd_extensions.nvim',
      ft = { 'c', 'cpp', 'objc', 'objcpp', 'cuda', 'proto' },
      opts = {},
    },
  },
  lsp = {
    name = 'clangd',
    server_configuration = {},
  },
  mason_packages = {
    'clangd',
    'codelldb',
  },
  setup = function()
    local dap = require 'dap'
    dap.adapters.codelldb = {
      type = 'server',
      port = '${port}',
      executable = {
        command = vim.fn.stdpath 'data' .. '/mason/bin/codelldb',
        args = { '--port', '${port}' },
        -- On windows you may have to uncomment this:
        -- detached = false,
      },
    }
    dap.configurations.cpp = {
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
    dap.configurations.c = dap.configurations.cpp
  end,
}
