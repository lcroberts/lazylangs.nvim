import { defineConfig } from 'vitepress'

export default defineConfig({
  title: "lazylangs.nvim",
  description: "Documentation for lazylangs.nvim",
  lang: 'en-US',
  sitemap: { hostname: 'https://lazylangs.com' },
  themeConfig: {
    sidebar: [
      { text: 'Introduction', link: '/' },
      { text: 'Installation', link: '/installation' },
      { text: 'Default Config', link: '/default_config' },
      { text: 'Making Language Configs', link: '/making_a_lang_config' },
      { text: 'Language Support', link: '/language_support' },
      { text: 'Language Details', link: '/language_details' },
      { text: 'Configuration Recipes', link: '/recipes' },
    ],

    socialLinks: [
      { icon: 'github', link: 'https://github.com/lcroberts/lazylangs.nvim' }
    ],

    search: {
      provider: 'local',
    }
  },
  markdown: {
    theme: {
      light: 'catppuccin-latte',
      dark: 'catppuccin-mocha',
    }
  }
})
