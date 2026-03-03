return {
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      -- LSP cho PHP & Blade
      intelephense = {
        filetypes = { "php", "blade" },
        settings = {
          intelephense = {
            files = {
              associations = { "*.php", "*.blade.php" },
              maxSize = 5000000,
            },
          },
        },
      },
      -- LSP cho HTML (để gợi ý thẻ div, span... trong Blade)
      html = { filetypes = { "html", "blade" } },
      -- LSP cho Tailwind (nếu dự án bạn dùng Tailwind)
      tailwindcss = {
        filetypes = { "html", "blade", "php", "javascript" },
      },
    },
  },
}
