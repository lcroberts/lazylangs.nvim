---@class ll.ServerConfiguration The configuration options for language server configuration
---@field cmd table? The command used to run the language server.
---@field filetypes table? The list of filetypes the server will attach to.
---@field capabilities lsp.ClientCapabilities? A list of LSP client capabilities. Extends the default plugin capabilities.
---@field on_attach vim.lsp.client.on_attach_cb? Overwrites the config provided lsp on_attach function
---@field settings table? Additional lsp settings that are returned if the server requests workspace/configuration. Language server specific.

---@class ll.LSP The LSP configuration table
---@field name string A language server name as defined by nvim-lspconfig.
---@field server_configuration ll.ServerConfiguration Language server configuration options.

---@class ll.Language The language configuration table structure
---@field plugins table? A lazy plugin spec. It is loaded by lazy and processed as any other would be.
---@field lsp ll.LSP|ll.LSP[]? A LSP table or a list of them.
---@field mason_packages string[]? A list of mason packages to be included in operations performed by LLMasonInstall, LLMasonUpdate, and LLMasonClean
---@field formatters table? A list of plugin names. For each plugin name there should be a list of language names that map to a formatter spec for the plugin.
---@field linters table? A list of plugin names. For each plugin name there should be a list of language names that map to a linter spec for the plugin.
---@field setup function? An additional function that gets called as part of the language setup. Any desired code can go here but long running code should be put into an autocommand that runs on UIEnter.
