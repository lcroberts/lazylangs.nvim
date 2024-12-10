---@module "LazyLanguages"
---@type ll.Language
return {
  lsp = {
    name = 'elixirls',
    server_configuration = {
      cmd = { require('LazyLanguages.helpers.paths').mason_bin_path 'elixir-ls' },
    },
  },
  mason_packages = {
    'elixir-ls',
  },
  setup = function()
    local dap = require 'dap'
    dap.adapters.mix_task = {
      type = 'executable',
      command = require('LazyLanguages.helpers.paths').mason_bin_path 'elixir-ls-debugger',
      args = {},
    }
    dap.configurations.elixir = {
      {
        type = 'mix_task',
        name = 'mix test',
        task = 'test',
        taskArgs = { '--trace' },
        request = 'launch',
        startApps = true,
        projectDir = '${workspaceFolder}',
        requireFiles = {
          'test/**/test_helper.exs',
          'test/**/*_test.exs',
        },
      },
      {
        type = 'mix_task',
        name = 'phx.server',
        request = 'launch',
        task = 'phx.server',
        projectDir = '${workspaceRoot}',
      },
    }
  end,
}
