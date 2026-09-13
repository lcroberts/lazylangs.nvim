---@module "lazylangs"
---@type ll.Language
local M = {
  lsp = {
    name = 'astro',
    server_configuration = {
      before_init = function(params, config)
        local util = require 'lspconfig.util'
        local tsdk = util.get_typescript_server_path(config.root_dir)
        local function has_ts(dir)
          return dir ~= ''
            and (vim.uv.fs_stat(vim.fs.joinpath(dir, 'typescript.js')) ~= nil
              or vim.uv.fs_stat(vim.fs.joinpath(dir, 'tsserverlibrary.js')) ~= nil)
        end

        if not has_ts(tsdk) then
          local mason_tsdk = vim.fs.joinpath(vim.fn.stdpath 'data', 'mason/packages/astro-language-server/node_modules/typescript/lib')
          if has_ts(mason_tsdk) then
            tsdk = mason_tsdk
          end
        end

        params.initializationOptions = params.initializationOptions or {}
        params.initializationOptions.typescript = params.initializationOptions.typescript or {}
        params.initializationOptions.typescript.tsdk = tsdk
      end,
    },
  },
  mason_packages = {
    'astro-language-server',
  },
}

return M
