return {
  {
    "MeanderingProgrammer/render-markdown.nvim",
    opts = {
      pipe_table = {
        enabled = false,
      },
    },
  },
  {
    "ice345/markdown-table-wrap.nvim",
    enabled = false,
    ft = { "markdown" },
    dependencies = { "MeanderingProgrammer/render-markdown.nvim" },
    opts = {},
    keys = {
      { "<leader>mr", "<cmd>MarkdownTableToggleReader<cr>", desc = "Toggle Markdown reader/source" },
      { "<leader>mi", "<cmd>MarkdownTableToggleInline<cr>", desc = "Toggle Markdown table inline view" },
      { "<leader>me", "<cmd>MarkdownTableEditSource<cr>", desc = "Edit Markdown source" },
    },
  },
}
