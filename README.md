# LazyLanguages.nvim

LazyLanguages.nvim is a library of pre-made language configurations and mechanisms to easily turn them on and off. It also provides easy mechanisms to override/extend existing configurations.

LazyLanguages.nvim is a plugin built on top of
[Lazy.nvim](https://github.com/folke/lazy.nvim) to provide premade language
specific configuration and to enable easily enabling/disabling certain
languages. I found myself commonly needing to use different languages for
school, personal projects, and work and often different languages in each
environment. This plugin was born out of a desire to easily be able to
enable/disable languages on a per machine and per week basis.

## Table of Contents

- [Language Support](#language-support)
    - [Compiled Languages](#compiled-languages)
    - [Interpreted Languages](#interpreted-languages)
    - [Markup Languages](#markup-languages)
- [Installing](#installing)
    - [Device Specific Languages](#device-specific-languages)
    - [Installing Mason Packages](#installing-mason-packages)
- [Default Config Options](#default-config-options)
- [Overriding A Language](#overriding-a-language)
    - [Language Config Types](#language-config-types)


## Language Support

Language aliases are what you put in the list that you provide to
LazyLanguages. If a language has multi]le aliases then they are symlinked to a
main file that is the first one in the list below. The file lookups are based
on file name so when you override a language you are actually overriding a
language alias. This allows for you to have finer granularity over
configurations that I conflate to be the same in the provided language
configurations. You can also add custom languages or different configurations
for the same language if you wish.

For more information on any individual language configs see [languages.md](https://github.com/lcroberts/LazyLanguages.nvim/blob/main/docs/languages.md).

### Compiled Languages

| Language Name | LSP | DAP Support | Language Aliases|
| ------------- | :--------------: | :--------------: | --------------|
| Go | ✅ | ✅ | go |
| Java | ✅ | ✅ | java |
| C# | ✅ | ✅ | csharp/cs |
| F# | ✅ | ✅ | fsharp/fs |
| Rust | ✅ | ✅ | rust/rs |
| C/Cpp | ✅ | ✅ | c/cpp |
| Zig | ✅ | ✅ | zig |
| Odin | ✅ | ✅ | odin |
| Scala | ✅ | ✅ | scala |
| Elixir | ✅ | ❌<sup>\*</sup> | elixir/ex/exs |

> \*: Is set up according to documentation however it is nonfunctional.


### Interpreted Languages

| Language Name | LSP | DAP Support | Language Aliases|
| ------------- | :--------------: | :--------------: | --------------|
| Python | ✅ | ✅ | python/py |
| Bash | ✅ | ❌ | bash/sh |
| Lua | ✅ | ❌ | lua |
| Javascript/Typescript | ✅ | ❌ | javascript/typescript/js/ts |

### Markup Languages

| Language Name | LSP |Language Aliases|
| ------------- | :--------------: | --------------|
| Latex | ✅ | latex/tex |
| Markdown | ✅ | markdown/md |
| HTML/CSS |  ✅  | html/css |


## Installing

You must first set up some global configuration options. These are needed
before Lazy.nvim loads plugins therefore they cannot be included in the setup
function.

```lua
vim.g.lazylangs = {
  -- '.' separated path relative to the lua directory in this case from the neovim config directory it's 'lua/languages'
  override_path = 'languages',
  langs = { "lua", "markdown", "python" }, -- List of strings of language names
}
```

Next you need to add the plugin with it's appropriate dependencies and the
import statement that includes the language specific plugins. If you wish to
see example configs for the various dependencies they are available in the
examples directory.

```lua
{
  'lcroberts/LazyLanguages.nvim',
  event = 'VeryLazy',
  -- Dependencies should be configured independently
  dependencies = {
    'neovim/nvim-lspconfig', -- LSP setup helpers
    'williamboman/mason.nvim', -- Package management
    'stevearc/conform.nvim', -- Formatting
    'mfussenegger/nvim-dap', -- Debug adapter protocol support
    -- Optional
    -- By default uses cmp.nvim to generate base capabilities if it's available.
    -- If you are using a different completion engine put that here and override the capabilities.
    'hrsh7th/nvim-cmp', 
  },
  ---@module 'LazyLanguages'
  ---@type ll.Config
  opts = {}, -- Put whatever options you wish here
  import = 'LazyLanguages.plugins', -- Imports language specific plugins
}
```

### Device Specific Languages

```lua
local langs = { 'lua', 'bash', 'markdown' } -- List of default languages
-- Attempts to require lua/languages.lua, can be added to a gitignore or similar.
local success, file_langs = pcall(require, 'languages')
if success then
  -- Add all new languages to list
  for _, language in ipairs(file_langs) do
    if not vim.list_contains(langs, language) then
      table.insert(langs, language)
    end
  end
end
-- Assign to global config variables
vim.g.lazylangs = {
  override_path = 'languages',
  langs = langs,
}
```

### Installing Mason Packages

If you do not use the automatic install options provided by the plugin you can
still install the mason packages for all configured languages using
`LLMasonInstall`. `LLMasonUpdate` can be used to update the packages installed
by LazyLanguages, and `LLMasonClean` can be used to remove installed packages.

## Default Config Options

```lua
local capabilities = vim.lsp.protocol.make_client_capabilities()
local success, cmp_lsp = pcall(require, 'cmp_nvim_lsp')
if success then
  capabilities = vim.tbl_deep_extend('force', capabilities, cmp_lsp.default_capabilities())
end
local config = {
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

    ---Default LSP client capabilities. May be extended/modified via individual language configs.
    ---Capabilities are merged when setting up the language server. So you only need to put overrides in language specific configs.
    ---@type lsp.ClientCapabilities
    capabilities = capabilities, -- cmp's recommended capabilities by default

    ---Flags for controlling the behavior of lsps
    ---@type table
    flags = {
      allow_incremental_sync = true,
      debounce_text_changes = 150,
    },
  },
}
```

## Overriding A Language

To override a language you can either add a file with the appropriate name in
your configured override directory or you can use the provided
`LLConfigOverride` command which will dump the existing config into the
language override directory.

Below is the config for C which uses all available features. The types section below shows all possible values.

```lua
---@module "LazyLanguages"
---@type ll.Language
return {
  -- Adds plugins for the language
  plugins = {
    {
      'p00f/clangd_extensions.nvim',
      ft = { 'c', 'cpp', 'objc', 'objcpp', 'cuda', 'proto' },
      opts = {},
    },
  },
  -- Sets up the LSP
  lsp = {
    name = 'clangd', -- LSP name as dictated by nvim-lspconfig
    server_configuration = {
      capabilities = {
        offsetEncoding = 'utf-8',
      },
    },
  },
  -- List of mason packages
  mason_packages = {
    'clangd',
    'codelldb',
  },
  -- Additional code to run as part of language setup process.
  setup = function()
    local dap = require 'dap'
    local dap_helpers = require 'LazyLanguages.helpers.dap'

    dap.adapters.cpp = dap_helpers.codelldb_adapter_config
    dap.configurations.cpp = dap_helpers.simple_codelldb_launch_config 'cpp'

    dap.adapters.c = dap_helpers.codelldb_adapter_config
    dap.configurations.c = dap_helpers.simple_codelldb_launch_config 'c'
  end,
}
```

### Language Config Types

```lua
---@class ll.ServerConfiguration The configuration options for language server configuration
---@field cmd table? The command used to run the language server.
---@field filetypes table? The list of filetypes the server will attach to.
---@field capabilities lsp.ClientCapabilities? A list of LSP client capabilities.
---@field settings table? Additional lsp settings that are returned if the server requests workspace/configuration.

---@class ll.LSP The LSP configuration table
---@field name string A language server name as defined by nvim-lspconfig.
---@field server_configuration ll.ServerConfiguration Language server configuration options. See relevant doccumentation.

---@class ll.Language The language configuration table structure
---@field plugins table? A lazy plugin spec. It is loaded by lazy and processed as any other would be.
---@field lsp ll.LSP? LSP configuration options. See relevant doccumentation.
---@field mason_packages string[]? A list of mason packages to be included in operations performed by LLMasonInstall, LLMasonUpdate, and LLMasonClean
---@field formatters table? A conform.nvim formatter spec.
---@field setup function? An additional function that gets called as part of the language setup. Any desired code can go here but long running code should be put into an autocommand that runs on UIEnter.
```

## Language TODO

| Language Name | LSP | DAP Support | Language Aliases |
| ------------- | --- | ----------- | ---------------- |
| Kotlin | ❌ | ❌ | N/A |
| Erlang | ❌ | ❌ | N/A |
| Ocaml | ❌ | ❌ | N/A |
| Haskell | ❌ | ❌ | N/A |
| PHP | ❌ | ❌ | N/A |
| Ruby | ❌ | ❌ | N/A |
| Dart | ❌ | ❌ | N/A |
| Perl | ❌ | ❌ | N/A |
| Julia | ❌ | ❌ | N/A |

