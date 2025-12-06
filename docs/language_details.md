# Language Configuration Details

For more information on any of the language configurations you can go directly
to the configuration file by clicking on the language name.

## [Go](https://github.com/lcroberts/lazylangs.nvim/blob/main/lua/lazylangs/languages/go.lua)

- LSP: gopls
- Formatter: LSP Builtin (gofmt)
- Additional plugins:
    - ray-x/go.nvim
    - leoluz/nvim-dap-go
- Notes: Requires go to be installed.

## [Java](https://github.com/lcroberts/lazylangs.nvim/blob/main/lua/lazylangs/languages/java.lua)

- LSP: Jdtls
- Formatter: LSP Builtin
- Additional Plugins:
    - mfussenegger/nvim-jdtls

## [C Sharp](https://github.com/lcroberts/lazylangs.nvim/blob/main/lua/lazylangs/languages/csharp.lua)

- LSP: Omnisharp
- Formatter: LSP Builtin
- Additional Plugins: None
- Notes: Requires dotnet

## [F Sharp](https://github.com/lcroberts/lazylangs.nvim/blob/main/lua/lazylangs/languages/fsharp.lua)

- LSP: fsautocomplete
- Formatter: fantomas
- Additional Plugins: None
- Notes: Requires dotnet

## [Rust](https://github.com/lcroberts/lazylangs.nvim/blob/main/lua/lazylangs/languages/rust.lua)

- LSP: Rust Analyzer (plugin configured)
- Formatter: rustfmt (plugin configured)
- Additional Plugins:
    - mrcjkb/rustaceanvim
- Notes: Uses your systems rust analyzer and rustfmt. It will automatically install them if rustup is installed.

## [C/Cpp](https://github.com/lcroberts/lazylangs.nvim/blob/main/lua/lazylangs/languages/c.lua)

- LSP: Clangd
- Formatter: LSP Builtin
- Additional Plugins:
    - p00f/clangd_extensions.nvim

## [Zig](https://github.com/lcroberts/lazylangs.nvim/blob/main/lua/lazylangs/languages/zig.lua)

- LSP: Zls
- Formatter: LSP Builtin
- Additional Plugins: None

## [Odin](https://github.com/lcroberts/lazylangs.nvim/blob/main/lua/lazylangs/languages/odin.lua)

- LSP: Ols
- Formatter: LSP Builtin
- Additional Plugins: None

## [Scala](https://github.com/lcroberts/lazylangs.nvim/blob/main/lua/lazylangs/languages/scala.lua)

- LSP: metals (plugin configured)
- Formatter: LSP Builtin
- Additional Plugins:
    - scalameta/nvim-metals - does most of the heavy lifting as far as debugging and lsp goes
- Notes: Requires coursier to be installed

## [Ocaml](https://github.com/lcroberts/lazylangs.nvim/blob/main/lua/lazylangs/languages/ocaml.lua)

- LSP: ocaml-lsp
- Formatter: ocamlfmt
- Additional Plugins: None
- Notes: Requires opam to be installed

## [Elixir](https://github.com/lcroberts/lazylangs.nvim/blob/main/lua/lazylangs/languages/elixir.lua)

- LSP: elixir-ls
- Formatter: LSP Builtin
- Additional Plugins: None
- Notes: Requires elixir and often times erlang to be installed. There are
debugging profiles set up according to the documentation however I have been
unable to verify they work.

## [Kotlin](https://github.com/lcroberts/lazylangs.nvim/blob/main/lua/lazylangs/languages/kotlin.lua)

- LSP: kotlin-lsp
- Formatter: None
- Additional Plugins: None
- Notes: The LSP is in pre-alpha and is a bit inconsistent

## [Python](https://github.com/lcroberts/lazylangs.nvim/blob/main/lua/lazylangs/languages/python.lua)

- LSP: Based Pyright
- Formatter: isort and black
- Additional Plugins:
    - mfussenegger/nvim-dap-python

## [Ruby](https://github.com/lcroberts/lazylangs.nvim/blob/main/lua/lazylangs/languages/ruby.lua)

- LSP: solargraph
- Formatter: LSP Builtin
- Additional Plugins:
  - suketa/nvim-dap-ruby: Sets up debugging

## [PHP](https://github.com/lcroberts/lazylangs.nvim/blob/main/lua/lazylangs/languages/php.lua)

- LSP: intelephense
- Formatter: Pint
- Linter: php-stan
- Additional Plugins: None
- Notes: For debugging to work make sure you have xdebug properly set up.

## [Bash](https://github.com/lcroberts/lazylangs.nvim/blob/main/lua/lazylangs/languages/bash.lua)

- LSP: Bashls
- Formatter: Shfmt
- Additional Plugins: None

## [Lua](https://github.com/lcroberts/lazylangs.nvim/blob/main/lua/lazylangs/languages/lua.lua)

- LSP: Luals
- Formatter: Stylua
- Additional Plugins:
    - folke/lazydev.nvim

## [Javascript/Typescript](https://github.com/lcroberts/lazylangs.nvim/blob/main/lua/lazylangs/languages/javascript.lua)

- LSP: Typescript Language Server (plugin configured)
- Formatter: Prettierd
- Additional Plugins:
    - pmizio/typescript-tools.nvim

## [Latex](https://github.com/lcroberts/lazylangs.nvim/blob/main/lua/lazylangs/languages/latex.lua)

- LSP: Texlab
- Formatter: LSP Builtin
- Additional Plugins:
    - lervag/vimtex

## [Markdown](https://github.com/lcroberts/lazylangs.nvim/blob/main/lua/lazylangs/languages/markdown.lua)

- LSP: Marksman
- Formatter: None
- Additional Plugins:
    - MeanderingProgrammer/render-markdown.nvim

## [HTML](https://github.com/lcroberts/lazylangs.nvim/blob/main/lua/lazylangs/languages/html.lua)

- LSP: Emmetls, Htmlls
- Formatter: LSP Builtin
- Additional Plugins: None

## [CSS](https://github.com/lcroberts/lazylangs.nvim/blob/main/lua/lazylangs/languages/css.lua)

- LSP: Cssls
- Formatter: LSP Builtin
- Additional Plugins: None

## [Tailwind](https://github.com/lcroberts/lazylangs.nvim/blob/main/lua/lazylangs/languages/tailwind.lua)

- LSP: Cssls, Tailwind language server
- Formatter: LSP Builtin
- Additional Plugins: None

## [GLSL](https://github.com/lcroberts/lazylangs.nvim/blob/main/lua/lazylangs/languages/glsl.lua)

- LSP: GLSL analyzer
- Formatter: LSP Builtin
- Additional Plugins: None

## [WGSL](https://github.com/lcroberts/lazylangs.nvim/blob/main/lua/lazylangs/languages/wgsl.lua)

- LSP: WGSL analyzer
- Formatter: LSP Builtin
- Additional Plugins: None
