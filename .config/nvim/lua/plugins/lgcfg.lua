return {
  {
    "folke/which-key.nvim",
    opts = {
      spec = {
        { "<leader>l", group = "Lazy" }, -- Đặt tên cho nhóm phím d
      },
    },
  },
  {
    "LazyVim/LazyVim",
    keys = {
      {
        "<leader>lc",
        function()
          Snacks.terminal.toggle("lazygit", {
            cwd = vim.fn.expand("~"),
            env = {
              GIT_DIR = vim.fn.expand("~/.cfg"),
              GIT_WORK_TREE = vim.fn.expand("~"),
            },
            win = {
              style = "float",
              width = 0.9,
              height = 0.9,
              on_buf = function(win)
                -- Chặn phím q ở mức buffer: Ẩn terminal
                vim.keymap.set("t", "q", "<cmd>hide<cr>", { buffer = win.buf, nowait = true })

                -- Chặn phím Q ở mức buffer: Gửi lệnh q thật để thoát hẳn
                vim.keymap.set("t", "Q", "q", { buffer = win.buf, nowait = true })
              end,
            },
          })
        end,
        desc = "Open config repo (q: Hide, Q: Quit)",
      },
    },
  },
}
