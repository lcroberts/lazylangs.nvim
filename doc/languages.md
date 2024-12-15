# Language Configuration Details

For more information on any of the language configurations you can go directly
to the configuration file by clicking on the language name.

## Table of Contents:

- [Go](#Go)
- [Java](#Java)
- [C Sharp](#C-Sharp)
- [F Sharp](#F-Sharp)
- [Rust](#Rust)
- [C/Cpp](#CCpp)
- [Zig](#Zig)
- [Odin](#Odin)
- [Python](#Python)
- [Bash](#Bash)
- [Lua](#Lua)
- [Javascript/Typescript](#JavascriptTypescript)
- [Latex](#Latex)
- [Markdown](#Markdown)
- [HTML/CSS](#HTMLCSS)
- [Scala](#Scala)
- [Elixir](#Elixir)
- [Ocaml](#Ocaml)

## [Go](https://github.com/lcroberts/LazyLanguages.nvim/blob/main/lua/LazyLanguages/languages/go.lua)

- LSP: gopls
- Formatter: LSP Builtin (gofmt)
- Additional plugins:
    - ray-x/go.nvim
    - leoluz/nvim-dap-go
- Notes: Requires go to be installed.

## [Java](https://github.com/lcroberts/LazyLanguages.nvim/blob/main/lua/LazyLanguages/languages/java.lua)

- LSP: Jdtls
- Formatter: LSP Builtin
- Additional Plugins:
    - mfussenegger/nvim-jdtls

## [C Sharp](https://github.com/lcroberts/LazyLanguages.nvim/blob/main/lua/LazyLanguages/languages/csharp.lua)
- LSP: Omnisharp
- Formatter: LSP Builtin
- Additional Plugins: None
- Notes: Requires dotnet

## [F Sharp](https://github.com/lcroberts/LazyLanguages.nvim/blob/main/lua/LazyLanguages/languages/fsharp.lua)
- LSP: fsautocomplete
- Formatter: fantomas
- Additional Plugins: None
- Notes: Requires dotnet

## [Rust](https://github.com/lcroberts/LazyLanguages.nvim/blob/main/lua/LazyLanguages/languages/rust.lua)
- LSP: Rust Analyzer (plugin configured)
- Formatter: rustfmt (plugin configured)
- Additional Plugins:
    - mrcjkb/rustaceanvim
- Notes: Uses your systems rust analyzer and rustfmt. It will automatically install them if rustup is installed.

## [C/Cpp](https://github.com/lcroberts/LazyLanguages.nvim/blob/main/lua/LazyLanguages/languages/c.lua)
- LSP: Clangd
- Formatter: LSP Builtin
- Additional Plugins:
    - p00f/clangd_extensions.nvim

## [Zig](https://github.com/lcroberts/LazyLanguages.nvim/blob/main/lua/LazyLanguages/languages/zig.lua)
- LSP: Zls
- Formatter: LSP Builtin
- Additional Plugins: None

## [Odin](https://github.com/lcroberts/LazyLanguages.nvim/blob/main/lua/LazyLanguages/languages/odin.lua)
- LSP: Ols
- Formatter: LSP Builtin
- Additional Plugins: None

## [Python](https://github.com/lcroberts/LazyLanguages.nvim/blob/main/lua/LazyLanguages/languages/python.lua)
- LSP: Based Pyright
- Formatter: isort and black
- Additional Plugins:
    - mfussenegger/nvim-dap-python

## [Bash](https://github.com/lcroberts/LazyLanguages.nvim/blob/main/lua/LazyLanguages/languages/bash.lua)
- LSP: Bashls
- Formatter: Shfmt
- Additional Plugins: None

## [Lua](https://github.com/lcroberts/LazyLanguages.nvim/blob/main/lua/LazyLanguages/languages/lua.lua)
- LSP: Luals
- Formatter: Stylua
- Additional Plugins:
    - folke/lazydev.nvim

## [Javascript/Typescript](https://github.com/lcroberts/LazyLanguages.nvim/blob/main/lua/LazyLanguages/languages/javascript.lua)
- LSP: Typescript Language Server (plugin configured)
- Formatter: Prettierd
- Additional Plugins:
    - pmizio/typescript-tools.nvim

## [Latex](https://github.com/lcroberts/LazyLanguages.nvim/blob/main/lua/LazyLanguages/languages/latex.lua)
- LSP: Texlab
- Formatter: LSP Builtin
- Additional Plugins:
    - lervag/vimtex

## [Markdown](https://github.com/lcroberts/LazyLanguages.nvim/blob/main/lua/LazyLanguages/languages/markdown.lua)
- LSP: Marksman
- Formatter: None
- Additional Plugins:
    - MeanderingProgrammer/render-markdown.nvim

## [HTML/CSS](https://github.com/lcroberts/LazyLanguages.nvim/blob/main/lua/LazyLanguages/languages/html.lua)
- LSP: Emmetls, Htmlls, Cssls
- Formatter: LSP Builtin
- Additional Plugins: None

## [Scala](https://github.com/lcroberts/LazyLanguages.nvim/blob/main/lua/LazyLanguages/languages/scala.lua)
- LSP: metals (plugin configured)
- Formatter: LSP Builtin
- Additional Plugins:
    - scalameta/nvim-metals - does most of the heavy lifting as far as debugging and lsp goes
- Notes: Requires coursier to be installed

## [Elixir](https://github.com/lcroberts/LazyLanguages.nvim/blob/main/lua/LazyLanguages/languages/elixir.lua)
- LSP: elixir-ls
- Formatter: LSP Builtin
- Additional Plugins: None
- Notes: Requires elixir and often times erlang to be installed. There are
debugging profiles set up according to the documentation however I have been
unable to verify they work.

## [Ocaml](https://github.com/lcroberts/LazyLanguages.nvim/blob/main/lua/LazyLanguages/languages/ocaml.lua)
- LSP: ocaml-lsp
- Formatter: ocamlfmt
- Additional Plugins: None
- Notes: Requires opam to be installed