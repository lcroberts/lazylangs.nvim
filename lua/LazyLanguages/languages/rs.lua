---@type ll.Language
return {
  plugins = {
    {
      'mrcjkb/rustaceanvim',
      version = '^5', -- Recommended
      lazy = false, -- This plugin is already lazy
    },
  },
  mason_packages = {
    'rust-analyzer',
    'codelldb',
  },
}
