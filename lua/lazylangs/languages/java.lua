---@module "lazylangs"
---@type ll.Language
return {
  plugins = {
    {
      'mfussenegger/nvim-jdtls',
      config = function()
        local opts = {
          cmd = { vim.fn.stdpath 'data' .. ('/mason/bin/jdtls'):gsub('/', require('lazylangs.helpers.paths').path_separator) },
          settings = {
            java = {
              inlayHints = {
                parameterNames = {
                  enabled = 'all',
                  exclusions = { 'this' },
                },
              },
            },
          },
          root_dir = vim.fs.dirname(vim.fs.find({ 'gradlew', '.git', 'mvnw' }, { upward = true })[1]),
          init_options = {
            bundles = {
              vim.fn.glob(
                vim.fn.stdpath 'data'
                .. ('/mason/packages/java-debug-adapter/extension/server/com.microsoft.java.debug.plugin-*.jar'):gsub(
                  '/',
                  require('lazylangs.helpers.paths').path_separator
                ),
                true
              ),
            },
          },
        }
        vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWinEnter' }, {
          group = vim.api.nvim_create_augroup('LLJdtls', { clear = true }),
          pattern = '*.java',
          callback = function()
            require('jdtls').start_or_attach(opts)
          end,
        })
      end,
    },
  },
  mason_packages = {
    'jdtls',
    'java-debug-adapter',
  },
}
