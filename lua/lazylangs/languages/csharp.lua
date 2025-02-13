---@module "lazylangs"
---@type ll.Language
return {
  lsp = {
    name = 'omnisharp',
    server_configuration = {
      cmd = { require('lazylangs.helpers.paths').mason_bin_path 'omnisharp' },
      settings = {
        RoslynExtensionsOptions = {
          InlayHintsOptions = {
            EnableForParameters = true,
            ForLiteralParameters = true,
            ForIndexerParameters = true,
            ForObjectCreationParameters = true,
            ForOtherParameters = true,
            SuppressForParametersThatDifferOnlyBySuffix = false,
            SuppressForParametersThatMatchMethodIntent = false,
            SuppressForParametersThatMatchArgumentName = false,
            EnableForTypes = true,
            ForImplicitVariableTypes = true,
            ForLambdaParameterTypes = true,
            ForImplicitObjectCreatio = true,
          },
        },
      },
    },
  },
  mason_packages = {
    'omnisharp',
    'netcoredbg',
  },
  setup = function()
    local debugging_plugin = vim.g.lazylang.debugging_plugin or nil
    if debugging_plugin == 'nvim-dap' then
      local dap = require 'dap'
      dap.adapters.csharp = {
        type = 'executable',
        command = require('lazylangs.helpers.paths').mason_bin_path 'netcoredbg',
        args = { '--interpreter=vscode' },
      }

      dap.configurations.cs = {
        {
          type = 'csharp',
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
