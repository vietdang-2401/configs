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
        "<leader>ld",
        function()
          Snacks.terminal.toggle({ "lazysql" }, {
            win = {
              style = "float",
              border = "rounded",
              width = 0.9,
              height = 0.9,
              on_buf = function(win)
                -- Chặn phím q ở mức buffer: Ẩn terminal
                vim.keymap.set("t", "q", function()
                  Snacks.terminal.get("lazysql"):hide()
                end, { buffer = win.buf, nowait = true })

                -- Chặn phím Q ở mức buffer: Gửi lệnh q thật để thoát hẳn
                vim.keymap.set("t", "Q", "q", { buffer = win.buf, nowait = true })
              end,
            },
          })
        end,
        desc = "LazySql (q: Hide, Q: Quit)",
      },
    },
  },
}
