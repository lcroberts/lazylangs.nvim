import { defineConfig } from 'vitepress'

// https://vitepress.dev/reference/site-config
export default defineConfig({
  title: "lazylangs.nvim",
  description: "Documentation for lazylangs.nvim",
  lang: 'en-US',
  sitemap: { hostname: 'https://lazylangs.com' },
  themeConfig: {
    // https://vitepress.dev/reference/default-theme-config

    sidebar: [
      {
        text: 'Getting Started',
        items: [
          { text: 'Introduction', link: '/' },
          { text: 'Languages', link: '/languages' },
        ]
      }
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
