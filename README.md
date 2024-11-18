# LazyLanguages.nvim

Language aliases are what you put in the list that you provide to
LazyLanguages. If a language has multiple aliases then they are symlinked to a
main file that is the first one in the list below. The file lookups are based
on file name so when you override a language you are actually overriding a
language alias. This allows for you to have finer granularity over
configurations that I conflate to be the same in the provided language
configurations. You can also add custom languages or different configurations
for the same language if you wish.

## Compiled Languages

| Language Name | LSP | DAP Support | Language Aliases|
| ------------- | :--------------: | :--------------: | --------------|
| Go | ✅ | ✅ | go |
| Java | ✅ | ✅ | java |
| C# | ✅ | ✅ | cs/c#/csharp |
| Rust | ✅ | ✅ | rs/rust |
| C/Cpp | ✅ | ✅ | c/cpp |
| Zig | ✅ | ✅ | zig |
| Odin | ✅ | ✅ | odin |

## Interpreted Languages

| Language Name | LSP | DAP Support | Language Aliases|
| ------------- | :--------------: | :--------------: | --------------|
| Python | ✅ | ✅ | py/python |
| Bash | ✅ | ❌ | sh/bash |
| Lua | ✅ | ❌ | lua |
| Javascript/Typescript | ✅ | ❌ | js/tsjavascript/typescript |

## Markup Languages

| Language Name | LSP |Language Aliases|
| ------------- | :--------------: | --------------|
| Latex | ✅ | tex/latex |
| Markdown | ✅ | md/markdown |
| HTML/CSS |  ✅  | html/css |

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

## TODO

- Fix debugger config collision possibility (if the config for the same debugger is used multiple times)
