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
      -- lazygit
      {
        "<leader>lg",
        function()
          -- Gọi hàm lazygit chuẩn của LazyVim nhưng thêm tùy chỉnh win
          Snacks.lazygit({
            win = {
              on_buf = function(win)
                -- 1. Nhấn q: Ẩn cửa sổ (Giữ nguyên phiên làm việc của Lazygit)
                vim.keymap.set("t", "q", function()
                  -- Lấy terminal instance của lazygit và ẩn nó đi
                  local terminal = Snacks.terminal.get("lazygit")
                  if terminal then
                    terminal:hide()
                  end
                end, { buffer = win.buf, nowait = true })

                -- 2. Nhấn Q: Thoát hẳn (Gửi lệnh 'q' thực sự vào Lazygit)
                vim.keymap.set("t", "Q", "q", { buffer = win.buf, nowait = true })
              end,
            },
          })
        end,
        desc = "Lazygit (q: Hide, Q: Quit)",
      },
      -- lazygit config repo
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
      -- lazysql
      {
        "<leader>ls",
        function()
          Snacks.terminal.toggle({ "lazysql" }, {
            win = {
              style = "float",
              width = 0.9,
              height = 0.9,
              on_buf = function(win)
                -- Chặn phím q ở mức buffer: Ẩn terminal
                vim.keymap.set("t", "q", function()
                  Snacks.terminal.get("lazysql"):hide()
                  -- vim.api.nvim_feedkeys("q", "t", false)
                end, { buffer = win.buf, nowait = true })

                -- Chặn phím Q ở mức buffer: Gửi lệnh q thật để thoát hẳn
                vim.keymap.set("t", "Q", "q", { buffer = win.buf, nowait = true })
              end,
            },
          })
        end,
        desc = "LazySql (q: Hide, Q: Quit)",
      },
      -- lazydocker
      {
        "<leader>ld",
        function()
          Snacks.terminal.toggle({ "lazydocker" }, {
            win = {
              style = "float",
              border = "rounded",
              width = 0.9,
              height = 0.9,
              on_buf = function(win)
                -- Chặn phím q ở mức buffer: Ẩn terminal
                vim.keymap.set("t", "q", function()
                  Snacks.terminal.get("lazydocker"):hide()
                end, { buffer = win.buf, nowait = true })

                -- Chặn phím Q ở mức buffer: Gửi lệnh q thật để thoát hẳn
                vim.keymap.set("t", "Q", "q", { buffer = win.buf, nowait = true })
              end,
            },
          })
        end,
        desc = "LazyDocker (q: Hide, Q: Quit)",
      },
      {
        "<leader>gg",
        function() end,
      },
      {
        "<leader>l",
        function()
          require("which-key").show({ keys = "<leader>l", loop = false })
        end,
        desc = "LazyVim group",
      },
      {
        "<leader>ll",
        function()
          require("lazy").home()
        end,
        desc = "Open Lazy",
      },
    },
  },
}
