---@module "lazylangs"
---@type ll.Language
return {
  lsp = {
    name = 'ocamllsp',
    server_configuration = {},
  },
  formatters = {
    conform = {
      ocaml = {
        'ocamlformat',
        lsp_fallback = true,
      },
    },
  },
  mason_packages = {
    'ocaml-lsp',
    'ocamlformat',
    'ocamlearlybird',
  },
  setup = function()
    local debugging_plugin = vim.g.lazylangs.debugging_plugin or nil
    if debugging_plugin == 'nvim-dap' then
      local dap = require 'dap'
      dap.adapters.ocamlearlybird = {
        type = 'executable',
        command = 'ocamlearlybird',
        args = { 'debug' },
      }
      dap.configurations.ocaml = {
        {
          name = 'OCaml Debug Bin',
          type = 'ocamlearlybird',
          request = 'launch',
          program = function()
            local default = vim.fn.glob(vim.fs.joinpath(vim.fn.getcwd(), '_build', 'default', 'bin', '*.bc'))
            if type(default) == 'table' then
              default = default[1]
            elseif type(default) == 'nil' then
              default = vim.fs.joinpath(vim.fn.getcwd(), '_build', 'default', 'bin', '')
            end
            return vim.fn.input('Path to executable: ', default, 'file')
          end,
          args = function()
            local args_string = vim.fn.input 'Arguments: '
            return vim.split(args_string, ' ')
          end,
        },
        {
          name = 'OCaml Debug Test',
          type = 'ocamlearlybird',
          request = 'launch',
          program = function()
            local default = vim.fn.glob(vim.fs.joinpath(vim.fn.getcwd(), '_build', 'default', 'test', '*.bc'))
            if type(default) == 'table' then
              default = default[1]
            elseif type(default) == 'nil' then
              default = vim.fs.joinpath(vim.fn.getcwd(), '_build', 'default', 'test', '')
            end
            return vim.fn.input('Path to executable: ', default, 'file')
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
