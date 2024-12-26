---@module "lazylangs"
---@type ll.Language
return {
  plugins = {
    {
      'elixir-tools/elixir-tools.nvim',
      version = '*',
      ft = { 'elixir', 'eelixir', 'heex', 'surface' },
      config = function()
        local elixir = require 'lazylangs.languages.elixir'
        local elixirls = require 'elixir.elixirls'

        elixir.setup {
          elixirls = {
            enable = true,
            settings = elixirls.settings {
              dialyzerEnabled = true,
            },
            on_attach = function(client, bufnr)
              require('lazylangs.config').lsp.on_attach(client, bufnr)
            end,
          },
        }
      end,
      dependencies = {
        'nvim-lua/plenary.nvim',
        'lcroberts/lazylangs.nvim',
      },
    },
  },
  mason_packages = {
    'elixir-ls',
  },
  setup = function()
    local debugging_plugin = vim.g.layzlangs.debugging_plugin or nil
    if debugging_plugin == 'nvim-dap' then
      local dap = require 'dap'
      dap.adapters.mix_task = {
        type = 'executable',
        command = require('lazylangs.helpers.paths').mason_bin_path 'elixir-ls-debugger',
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
            -- for umbrella projects
            'apps/**/test/**/test_helper.exs',
            'apps/**/test/**/*_test.exs',
            -- for PDQ
            'lib/**/*_test.exs',
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
    end
  end,
}
