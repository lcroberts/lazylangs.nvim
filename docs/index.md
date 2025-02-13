---
title: Introduction
---

# What is lazylangs.nvim?

lazylangs.nvim is a tool made to simplify setting up tools for programming
languages by centralizing all tooling configuration into one place. It
integrates with existing plugins and uses their configuration methods whenever
possible. A selection of pre-made language configurations are included, though
for any language you are programming in often you will likely want to override
it to tailor it to your tastes.

## Features

- Plugin support through [lazy.nvim](https://github.com/folke/lazy.nvim).
- LSP support through [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig).
- Formatting support through [conform.nvim](https://github.com/stevearc/conform.nvim) (though more plugin support is planned).
- Linting support through [nvim-lint](https://github.com/mfussenegger/nvim-lint) (though more plugin support is planned).
- Debugging support for some languages through [nvim-dap](https://github.com/mfussenegger/nvim-dap).
- Automatically installing the tools you need through [mason.nvim](https://github.com/williamboman/mason.nvim).
- A collection of pre-made language setups.
- Ability to easily override and add language setups.

## Versioning

lazylangs follows a x.x.x versioning scheme. The first number will only
increment when a breaking change is made to the plugin setup that requires user
intervention. The second number increments any time there is a change that
might affect users. This includes changes to a language configuration or if new
plugin support is added. The final number is incremented for bug fixes and or
internal code changes that will have no effect on the users of the plugin.
