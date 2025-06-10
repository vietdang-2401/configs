return {
  "olimorris/codecompanion.nvim",
  opts = {
    display = {
      chat = {
        show_settings = true,
      },
    },
  },
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
  keys = {
    {
      "<leader>ac",
      "<cmd>CodeCompanionActions<cr>",
      mode = { "n", "v" },
      noremap = true,
      silent = true,
      desc = "CodeCompanion actions",
    },
    {
      "<leader>aa",
      "<cmd>CodeCompanionChat Toggle<cr>",
      mode = { "n", "v" },
      noremap = true,
      silent = true,
      desc = "CodeCompanion chat",
    },
    {
      "<leader>ad",
      "<cmd>CodeCompanionChat Add<cr>",
      mode = "v",
      noremap = true,
      silent = true,
      desc = "CodeCompanion add to chat",
    },
  },
}
