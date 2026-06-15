return {
  "olimorris/codecompanion.nvim",
  opts = {
    display = {
      chat = {
        show_settings = false,
      },
    },
    interactions = {
      cli = {
        agent = "piai",
        agents = {
          piai = {
            cmd = "cce",
            args = { "pirago" },
            description = "Claude Code CLI",
            provider = "terminal",
          },
        },
        window = {
          layout = "vertical",
          width = 0.4,
          height = 0.6,
          opts = {
            list = false,
          },
        },
      },
    },
    extensions = {
      history = {
        enabled = true,
        opts = {
          keymap = "gh",
          save_chat_keymap = "gA",
          auto_save = false,
          auto_generate_title = true,
          continue_last_chat = false,
          delete_on_clearing_chat = false,
          picker = "snacks",
          enable_logging = false,
          dir_to_save = vim.fn.stdpath("data") .. "/codecompanion-history",
        },
      },
      -- mcphub = {
      --   callback = "mcphub.extensions.codecompanion",
      --   opts = {
      --     show_result_in_chat = true, -- Show mcp tool results in chat
      --     make_vars = true, -- Convert resources to #variables
      --     make_slash_commands = true, -- Add prompts as /slash commands
      --   },
      -- },
    },
  },
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    "ravitemer/codecompanion-history.nvim", -- Save and load conversation history
    {
      "ravitemer/mcphub.nvim", -- Manage MCP servers
      enalbed = false,
      cmd = "MCPHub",
      build = "npm install -g mcp-hub@latest",
      config = function()
        require("mcphub").setup()
      end,
    },
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
    {
      "<leader>ah",
      "<cmd>CodeCompanionHistory<cr>",
      mode = { "v", "n" },
      noremap = true,
      silent = true,
      desc = "CodeCompanion list chat history",
    },
    {
      "<leader>ag",
      "<cmd>CodeCompanionCLI<cr>",
      mode = { "v", "n" },
      noremap = true,
      silent = true,
      desc = "CodeCompanion CLI",
    },
    {
      "<leader>at",
      "<cmd>lua require('codecompanion').toggle()<cr>",
      mode = { "v", "n" },
      noremap = true,
      silent = true,
      desc = "CodeCompanion toggle",
    },
  },
  lazy = false,
}
