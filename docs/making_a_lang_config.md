# Making A Language Config

## Language Table Structure

Every field in a language table is optional. Meaning you can leave out any that you wish to. The fields are as follows:
- plugins: A lazy plugin spec to be included when the language is enabled.
- lsp: Consists of a name as defined by [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig) and a server configuration table. It may also be a list of the aforementioned layout if you wish to have multiple language servers enabled. For more information on the server configuration table see the types section.
- mason_packages: A list of strings. These should be [mason.nvim](https://github.com/williamboman/mason.nvim) package names.
- formatters and linters: While these are two separate fields they follow the same structure. The first layer of the table has keys that are plugin names (any .nvim suffix is removed and "-" are replaced with "_"). The next layer is a list of file types. These should map to a valid plugin specific spec of formatters or linters. So for example `formatters.conform.lua` should map to a conform compatible formatter spec that is applied to lua files.
- setup: A function for any additional setup code that needs to be run. This is primarily used for setting up debug adapters though you could put anything you wish in here.

To see example set up you can go to the [language details](./language_details) page and click on the language titles to be taken to the source for any language.

## Language Configuration Types

```lua
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
```

## Dumping/Overriding An Included Language Config {#dumping-an-included-language-config}

lazylangs provides the user command `LLCreateOverride`. This provides an easy
mechanism to dump the existing language config into your set override
directory. This may also be used as a way to freeze the config across lazylangs
updates.

## Creating A Language Config

If you wish to create a language config that is not in the defaults you can do
that by creating a file in your overrides directory. The filename (minus the
.lua) is what you will use to enable the language. You can create symlinks for
any language aliases you wish to have. 

For example say you wanted to have a setup for
[monkey](https://monkeylang.org/). First you would go to your language
overrides directory and make a file called `monkey.lua`. You could then create
something similar to the following:

:::info NOTE

Note none of the plugins/packages in this table are real. It is solely to
demonstrate what a full featured language table might look like. Also any of
the top level fields can be left out if you do not need them.

:::


```lua
---@module "lazylangs"
---@type ll.Language
return {
  plugins = {
    {
      'monkey/monkey.nvim'
      opts = {},
    },
  },
  lsp = {
    name = "monkeyls",
    -- server_configuration is normally just an empty table. There are few times where anything inside is required
    server_configuration = {
      cmd = { 'monkeyls' },
      -- filetypes = { ... },
      -- capabilities = { ... },
      -- on_attach = function()
      --  ...
      -- end,
      -- settings = { ... },
    },
  },
  formatters = {
    conform = {
      monkey = {
        'monkeyfmt',
      },
    },
  },
  linters = {
    nvim_lint = {
      monkey = { 'monkeylint' },
    },
  },
  mason_packages = {
    'monkeyls',
    'monkeyfmt',
    'monkeylint',
  },
  setup = function()
    print("Hello from monkey setup")
  end,
}
```
