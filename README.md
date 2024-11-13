# LazyLanguages.nvim

Language aliases are what you put in the list that you provide to
LazyLanguages. If a language has multiple aliases then they are symlinked to a
main file that is generally the first one in the list below. The file lookups
are based on file name so when you override a language you are actually
overriding a language alias. This allows for you to have finer granularity over
configurations that I conflate to be the same in the provided language
configurations.

| Language Name | LSP | DAP Support | Language Aliases|
| ------------- | -------------- | -------------- | --------------|
| Go | ✅ | ✅ | go |
| Java | ✅ | ✅ | java |
| C# | ✅ | ✅ | cs/c#/csharp |
| Rust | ✅ | ✅ | rust/rs |
| C/Cpp | ✅ | ✅ | c/cpp |
| Zig | ✅ | ✅ | zig |
| Python | ✅ | ✅ | python/py |
| Bash | ✅ | ❌ | bash |
| Lua | ✅ | ❌ | lua |
| Javascript/Typescript | ✅ | ❌ | javascript/typescript/js/ts |
| Latex | ✅ | ❌ | latex/tex |
| Markdown | ✅ | ❌ | markdown/md |

## Language TODO

- PHP
- Elixir
- Ocaml
- Odin
- F#
- Haskell
- Kotlin
- Scala
- Ruby
- Dart
- Perl

## TODO

- Improve utils.notify
- Automatic updating of language servers
