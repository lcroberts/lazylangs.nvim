vim.api.nvim_create_autocmd({ 'UIEnter' }, {
  group = vim.api.nvim_create_augroup('LLBladeParser', { clear = true }),
  callback = function()
    local parser_config = require('nvim-treesitter.parsers').get_parser_configs()
    parser_config.blade = {
      install_info = {
        url = 'https://github.com/EmranMR/tree-sitter-blade',
        files = { 'src/parser.c' },
        branch = 'main',
      },
      filetype = 'blade',
    }

    vim.filetype.add {
      pattern = {
        ['.*%.blade%.php'] = 'blade',
      },
    }
    -- vim.cmd [[
    -- " Set the *.blade.php file to be filetype of blade
    -- augroup BladeFiltypeRelated
    --   au BufNewFile,BufRead *.blade.php set ft=blade
    -- augroup END
    -- ]]
  end,
})
