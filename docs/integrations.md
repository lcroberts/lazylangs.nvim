# Integrations

All integrations are optional. If you do not set the plugin in the global
config options it will not be used.

## blink.cmp

There are integrations with blink.cmp for both the default capabilities for lsp
as well as for certain plugins such as
[lazydev](https://github.com/folke/lazydev.nvim). For this to work properly
make sure anywhere you include `opts_extend = { 'sources' }` in your lazy
plugin spec. This should look like:

```lua
{
  'saghen/blink.cmp',
  -- Any other lazy config here
  opts = {}, -- Whatever options you need here
  opts_extend = { 'sources' }, -- Whatever parts of the options table you need to extend
}
```

## nvim-cmp

There are integrations with nvim-cmp for both the default lsp capabilities as
well as for certain plugins such as
[lazydev](https://github.com/folke/lazydev.nvim). Other than setting it as
your completion plugin no other configuration is necessary.

## conform.nvim

Every language that does not use the lsp builtin formatter has a table with
conform formatters in it. No additional configuration is necessary other than
setting it as your formatting plugin.

## nvim-lint

Currently only bash has a linter configured, and no additional configuration is
necessary other than setting it as your linting plugin.

## nvim-dap

For a full list of languages with debugging supported see [language
support](./language_support). No configuration other than setting nvim-dap as
your debugging plugin is needed in most cases. There may be some setup you have
to do on a per project basis depending on the language however.
