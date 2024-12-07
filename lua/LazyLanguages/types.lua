---@meta
--# selene: allow(unused_variable)

---@class ll.ServerConfiguration
---@field cmd table? The command used to run the language server.
---@field filetypes table? The list of filetypes the server will attach to.
---@field capabilities lsp.ClientCapabilities? A list of LSP client capabilities.
---@field settings table? Additional lsp settings that are returned if the server requests workspace/configuration.

---@class ll.Lsp
---@field name string A language server name as defined by nvim-lspconfig.
---@field server_configuration ll.ServerConfiguration Language server configuration options. See relevant doccumentation.

---@class ll.Language
---@field plugins table? A lazy plugin spec. It is loaded by lazy and processed as any other would be.
---@field lsp ll.Lsp? LSP configuration options. See relevant doccumentation.
---@field mason_packages string[]? A list of mason packages to be included in operations performed by LLMasonInstall, LLMasonUpdate, and LLMasonClean
---@field formatters table? A conform.nvim formatter spec.
---@field setup function? An additional function that gets called as part of the language setup. Any desired code can go here but long running code should be put into an autocommand that runs on UIEnter.
