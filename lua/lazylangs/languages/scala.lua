---@module "lazylangs"
vim.pack.add { 'https://github.com/scalameta/nvim-metals' }

local metals_config = require('metals').bare_config()
metals_config.on_attach = function(client, buffer)
  require('lazylangs.config').lsp.on_attach(client, buffer)
  require('metals').setup_dap()
end
local nvim_metals_group = vim.api.nvim_create_augroup('LL-nvim-metals', { clear = true })
vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'scala', 'sbt' },
  callback = function()
    require('metals').initialize_or_attach(metals_config)
  end,
  group = nvim_metals_group,
})

---@type ll.Language
return {
  setup = function()
    local debugging_plugin = vim.g.lazylangs.debugging_plugin or nil
    if debugging_plugin == 'nvim-dap' then
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
    end
  end,
}
