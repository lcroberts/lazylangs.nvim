---@type ll.Language
return {
  lsp = {
    name = 'ols',
    server_configuration = {},
  },
  mason_packages = {
    'ols',
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

    dap.configurations.odin = {
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
