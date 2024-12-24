# Configuration Options

Below are the default configuration options for the plugin. 

```lua
---@class ll.Config
{
  mason = {
    ---Are mason packages for languages automatically installed
    ---@type boolean
    automatic_install = false,

    ---Are mason packages for languages automatically updated
    ---@type boolean
    automatic_update = false,
  },

  lsp = {
    ---The lsp on attach function to be forwarded to lspconfig
    ---@param client vim.lsp.Client
    ---@param bufnr number
    on_attach = function(client, bufnr)
      if client.server_capabilities.inlayHintProvider then
        vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
      end
    end,

    ---Default LSP client capabilities. May be extended/modified via
    ---individual language configs. Capabilities are merged when setting up
    ---the language server. So you only need to put overrides in language
    ---specific configs. The default value is generated based on the
    ---completion plugin you use.
    ---@type lsp.ClientCapabilities
    capabilities = nil,

    ---Flags for controlling the behavior of lsps
    ---@type table
    flags = {
      allow_incremental_sync = true,
      debounce_text_changes = 150,
    },
  },
}
```
