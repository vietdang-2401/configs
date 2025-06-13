return {
  "olimorris/codecompanion.nvim",
  opts = {
    display = {
      chat = {
        show_settings = true,
      },
    },
    extensions = {
      history = {
        enabled = true,
        opts = {
          keymap = "gh",
          save_chat_keymap = "gS",
          auto_save = false,
          auto_generate_title = true,
          continue_last_chat = false,
          delete_on_clearing_chat = false,
          picker = "snacks",
          enable_logging = false,
          dir_to_save = vim.fn.stdpath("data") .. "/codecompanion-history",
        },
      },
    },
  },
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    "ravitemer/codecompanion-history.nvim", -- Save and load conversation history
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
  lazy = false,
}
