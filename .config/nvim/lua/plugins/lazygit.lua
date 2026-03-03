return {
  {
    "LazyVim/LazyVim",
    keys = {
      {
        "<leader>gg",
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
    },
  },
}
