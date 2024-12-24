# User Commands

lazylangs.nvim provides several user commands to help with common operations. They are all prefixed with 'LL'.

- `LLMasonInstall`: Installs all mason packages listed in enabled language configurations.
- `LLMasonUpdate`: Updates all packages listed in enabled language configurations.
- `LLMasonClean`: Removes all packages installed by enabled language configurations. Note: If a language is no longer enabled it's packages will not be uninstalled.
- `LLConfigOverride`: Takes a language name/alias and dumps that config into your provided override directory.
