# Configuration Recipes

Below is a collection of useful snippets to help with either configuration or
creating language tables.

## Different Languages Per Device

You may want to use different languages on different devices with the same
neovim config. Here is a snippet that allows you to easily do that. This should
be put into your init.lua before you initialize lazy.nvim.

```lua
local langs = { 'lua', 'bash', 'markdown' } -- Languages you want on every machine
-- Try to source lua/languages.lua which should return a list of strings
local success, file_langs = pcall(require, 'languages')
if success then
  -- Iterate through the languages and insert it into the language list
  for _, language in ipairs(file_langs) do
    if not vim.list_contains(langs, language) then
      table.insert(langs, language)
    end
  end
end
vim.g.lazylangs = {
  override_path = 'languages', -- '.' separated path relative to the lua directory
  formatting_plugin = 'conform',
  completion_plugin = 'nvim-cmp',
  linting_plugin = 'nvim-lint',
  debugging_plugin = 'nvim-dap',
  langs = langs, -- string[] of language names
}
```
