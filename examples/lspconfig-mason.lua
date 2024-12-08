return {
  'neovim/nvim-lspconfig',
  event = 'VeryLazy',
  dependencies = {
    {
      'williamboman/mason.nvim',
      event = 'VeryLazy',
      opts = {},
    },
  },
  config = function()
    -- Set up keybindings on LSP Attach
    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('lsp-attach', { clear = true }),
      callback = function(event)
        local map = function(keys, func, desc)
          vim.keymap.set('n', keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
        end
        local vmap = function(keys, func, desc)
          vim.keymap.set('v', keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
        end
        local imap = function(keys, func, desc)
          vim.keymap.set('i', keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
        end

        map('<leader>rn', function()
          vim.lsp.buf.rename()
        end, '[R]e[n]ame')

        map('<leader>ca', function()
          vim.lsp.buf.code_action()
        end, '[C]ode [A]ction')
        vmap('<leader>ca', function()
          vim.lsp.buf.code_action()
        end, '[C]ode [A]ction')

        map('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
        map('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
        map('gi', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
        map('<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')
        map('<leader>ss', require('telescope.builtin').lsp_document_symbols, '[S]earch [S]ymbols')
        map('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')
        map('<leader>rr', '<cmd>LspRestart<cr>', 'Restart LSP')

        -- See `:help K` for why this keymap
        map('K', function()
          vim.lsp.buf.hover()
        end, 'Hover Documentation')
        map('<M-k>', function()
          vim.lsp.buf.signature_help()
        end, 'Signature Documentation')

        -- Lesser used LSP functionality
        map('gD', function()
          vim.lsp.buf.declaration()
        end, '[G]oto [D]eclaration')

        -- Diagnostic
        map(']d', vim.diagnostic.goto_next, 'Go to next diagnostic message')
        map('[d', vim.diagnostic.goto_prev, 'Go to previous diagnostic message')
        map('<leader>df', vim.diagnostic.open_float, 'floating diagnostic message')
        map('<leader>dl', vim.diagnostic.setloclist, 'Open diagnostics list')

        imap('<M-h>', vim.lsp.buf.signature_help, 'Show signature help')

        local client = vim.lsp.get_client_by_id(event.data.client_id)
        if client and client.server_capabilities.inlayHintProvider and vim.lsp.inlay_hint then
          map('<leader>ti', function()
            vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
          end, '[t]oggle [i]nlay hints')
        end
      end,
    })
  end,
}
