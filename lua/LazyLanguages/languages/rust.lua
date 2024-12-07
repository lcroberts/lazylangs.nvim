---@module "LazyLanguages"
---@type ll.Language
return {
  plugins = {
    {
      'mrcjkb/rustaceanvim',
      version = '^5', -- Recommended
      lazy = false, -- This plugin is already lazy
      config = function()
        vim.g.rustaceanvim = {
          -- Plugin configuration
          tools = {},
          -- LSP configuration
          server = {
            on_attach = require('LazyLanguages.config').lsp.on_attach, -- Config should be loaded by the time this is ran
            capabilities = require('LazyLanguages.config').lsp.capabilities,
          },
        }
      end,
    },
  },
  mason_packages = {
    'codelldb',
  },
  setup = function()
    vim.api.nvim_create_autocmd('UIEnter', {
      group = vim.api.nvim_create_augroup('LazyLangsRustAnalyzer', { clear = true }),
      once = true,
      desc = 'Install rust-analyzer if it is not installed',
      callback = function()
        local helpers = require 'LazyLanguages.helpers.vim'
        if not vim.fn.executable 'rustup' then
          helpers.notify_once("'rustup' is not executable. Please add it to your path.", vim.log.levels.WARN)
          return
        end
        -- Check if rust-analyzer has been installed but is not currently available for the current toolchain
        local result = vim.system({ 'rust-analyzer', '--version' }):wait()
        if result.code ~= 0 then
          helpers.notify 'Installing rust analyzer.'
          vim.system({ 'rustup', 'component', 'add', 'rust-analyzer' }, {}, function(obj)
            if obj.stdout and obj.stdout ~= '' then
              helpers.notify(obj.stdout)
            end
            if obj.stderr and obj.stderr ~= '' then
              helpers.notify(obj.stderr)
            end
            if obj.code == 0 then
              helpers.notify "'rust-analyzer' installed successfully"
            end
          end)
        end
      end,
    })
  end,
}
