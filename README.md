# LazyLanguages.nvim

Language aliases are what you put in the list that you provide to
LazyLanguages. If a language has multiple aliases then they are symlinked to a
main file that is the first one in the list below. The file lookups are based
on file name so when you override a language you are actually overriding a
language alias. This allows for you to have finer granularity over
configurations that I conflate to be the same in the provided language
configurations. You can also add custom languages or different configurations
for the same language if you wish.

## Installing

TODO: This

## Compiled Languages

| Language Name | LSP | DAP Support | Language Aliases|
| ------------- | :--------------: | :--------------: | --------------|
| Go | ✅ | ✅ | go |
| Java | ✅ | ✅ | java |
| C# | ✅ | ✅ | csharp/cs |
| Rust | ✅ | ✅ | rust/rs |
| C/Cpp | ✅ | ✅ | c/cpp |
| Zig | ✅ | ✅ | zig |
| Odin | ✅ | ✅ | odin |

## Interpreted Languages

| Language Name | LSP | DAP Support | Language Aliases|
| ------------- | :--------------: | :--------------: | --------------|
| Python | ✅ | ✅ | python/py |
| Bash | ✅ | ❌ | bash/sh |
| Lua | ✅ | ❌ | lua |
| Javascript/Typescript | ✅ | ❌ | javascript/typescript/js/ts |

## Markup Languages

| Language Name | LSP |Language Aliases|
| ------------- | :--------------: | --------------|
| Latex | ✅ | latex/tex |
| Markdown | ✅ | markdown/md |
| HTML/CSS |  ✅  | html/css |

## Overriding A Language

To override a language you can either add a file with the appropriate name in
your configured override directory or you can use the provided
`LLConfigOverride` command which will dump the existing config into the
language override directory.

## Language TODO
| Language Name | LSP | DAP Support | Language Aliases |
| ------------- | --- | ----------- | ---------------- |
| F# | ❌ | ❌ | N/A |
| Scala | ❌ | ❌ | N/A |
| Kotlin | ❌ | ❌ | N/A |
| Elixir | ❌ | ❌ | N/A |
| Erlang | ❌ | ❌ | N/A |
| Ocaml | ❌ | ❌ | N/A |
| Haskell | ❌ | ❌ | N/A |
| PHP | ❌ | ❌ | N/A |
| Ruby | ❌ | ❌ | N/A |
| Dart | ❌ | ❌ | N/A |
| Perl | ❌ | ❌ | N/A |
| Julia | ❌ | ❌ | N/A |

## Language Configuration Details

For more information on any of the language configurations you can go directly
to the configuration file by clicking on the language name.

### Table of Contents:

- [Go](#Go)
- [Java](#Java)
- [C Sharp](#C-Sharp)
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

### [Go](https://github.com/lcroberts/LazyLanguages.nvim/blob/main/lua/LazyLanguages/languages/go.lua)

- LSP: gopls
- Formatter: LSP Builtin (gofmt)
- Additional plugins:
    - ray-x/go.nvim
    - leoluz/nvim-dap-go
- Notes: Requires go to be installed.

### [Java](https://github.com/lcroberts/LazyLanguages.nvim/blob/main/lua/LazyLanguages/languages/java.lua)

- LSP: Jdtls
- Formatter: LSP Builtin
- Additional Plugins:
    - mfussenegger/nvim-jdtls

### [C Sharp](https://github.com/lcroberts/LazyLanguages.nvim/blob/main/lua/LazyLanguages/languages/csharp.lua)
- LSP: Omnisharp
- Formatter: LSP Builtin
- Additional Plugins: None

### [Rust](https://github.com/lcroberts/LazyLanguages.nvim/blob/main/lua/LazyLanguages/languages/rust.lua)
- LSP: Rust Analyzer (plugin configured)
- Formatter: rustfmt (plugin configured)
- Additional Plugins:
    - mrcjkb/rustaceanvim
- Notes: Uses your systems rust analyzer and rustfmt. It will automatically install them if rustup is installed.

### [C/Cpp](https://github.com/lcroberts/LazyLanguages.nvim/blob/main/lua/LazyLanguages/languages/c.lua)
- LSP: Clangd
- Formatter: LSP Builtin
- Additional Plugins:
    - p00f/clangd_extensions.nvim

### [Zig](https://github.com/lcroberts/LazyLanguages.nvim/blob/main/lua/LazyLanguages/languages/zig.lua)
- LSP: Zls
- Formatter: LSP Builtin
- Additional Plugins: None

### [Odin](https://github.com/lcroberts/LazyLanguages.nvim/blob/main/lua/LazyLanguages/languages/odin.lua)
- LSP: Ols
- Formatter: LSP Builtin
- Additional Plugins: None

### [Python](https://github.com/lcroberts/LazyLanguages.nvim/blob/main/lua/LazyLanguages/languages/python.lua)
- LSP: Based Pyright
- Formatter: isort and black
- Additional Plugins:
    - mfussenegger/nvim-dap-python

### [Bash](https://github.com/lcroberts/LazyLanguages.nvim/blob/main/lua/LazyLanguages/languages/bash.lua)
- LSP: Bashls
- Formatter: Shfmt
- Additional Plugins: None

### [Lua](https://github.com/lcroberts/LazyLanguages.nvim/blob/main/lua/LazyLanguages/languages/lua.lua)
- LSP: Luals
- Formatter: Stylua
- Additional Plugins:
    - folke/lazydev.nvim

### [Javascript/Typescript](https://github.com/lcroberts/LazyLanguages.nvim/blob/main/lua/LazyLanguages/languages/javascript.lua)
- LSP: Typescript Language Server (plugin configured)
- Formatter: Prettierd
- Additional Plugins:
    - pmizio/typescript-tools.nvim

### [Latex](https://github.com/lcroberts/LazyLanguages.nvim/blob/main/lua/LazyLanguages/languages/latex.lua)
- LSP: Texlab
- Formatter: LSP Builtin
- Additional Plugins:
    - lervag/vimtex

### [Markdown](https://github.com/lcroberts/LazyLanguages.nvim/blob/main/lua/LazyLanguages/languages/markdown.lua)
- LSP: Marksman
- Formatter: None
- Additional Plugins:
    - MeanderingProgrammer/render-markdown.nvim

### [HTML/CSS](https://github.com/lcroberts/LazyLanguages.nvim/blob/main/lua/LazyLanguages/languages/html.lua)
- LSP: Emmetls, Htmlls, Cssls
- Formatter: LSP Builtin
- Additional Plugins: None

