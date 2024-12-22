---@module "lazylangs"
---@type ll.Language
return {
  plugins = {
    {
      'scalameta/nvim-metals',
      dependencies = {
        'nvim-lua/plenary.nvim',
      },
      ft = { 'scala', 'sbt' },
      opts = function()
        local metals_config = require('metals').bare_config()
        metals_config.on_attach = function(client, buffer)
          require('lazylangs.config').lsp.on_attach(client, buffer)
          require('metals').setup_dap()
        end

        return metals_config
      end,
      config = function(self, metals_config)
        local nvim_metals_group = vim.api.nvim_create_augroup('LL-nvim-metals', { clear = true })
        vim.api.nvim_create_autocmd('FileType', {
          pattern = self.ft,
          callback = function()
            require('metals').initialize_or_attach(metals_config)
          end,
          group = nvim_metals_group,
        })
      end,
    },
  },
  setup = function()
    local dap = require 'dap'

    dap.configurations.scala = {
      {
        type = 'scala',
        request = 'launch',
        name = 'Run or Test Target',
        metals = {
          runType = 'runOrTestFile',
        },
      },
      {
        type = 'scala',
        request = 'launch',
        name = 'Test Target',
        metals = {
          runType = 'testTarget',
        },
      },
      {
        type = 'scala',
        request = 'attach',
        name = 'Attach to Localhost',
        hostName = 'localhost',
        port = 5005,
        buildTarget = 'root',
      },
    }
  end,
}
