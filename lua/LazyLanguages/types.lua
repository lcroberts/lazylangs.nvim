---@meta
--# selene: allow(unused_variable)

---@class ll.ServerConfiguration
---@field cmd table?
---@field filetypes table?
---@field capabilities table?
---@field settings table?

---@class ll.Lsp
---@field name string
---@field server_configuration ll.ServerConfiguration

---@class ll.Language
---@field plugins table?
---@field lsp ll.Lsp?
---@field mason_packages string[]?
---@field formatters table?
---@field setup function?
