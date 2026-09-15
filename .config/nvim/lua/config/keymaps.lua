-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
vim.keymap.set("n", "gf", function()
  local cfile = vim.fn.expand("<cfile>")
  if cfile == "" then
    return
  end

  -- Tìm đường dẫn thực tế của file theo thiết lập 'path' của Vim
  local filepath = vim.fn.findfile(cfile)

  -- Nếu không tìm thấy file nào tồn tại
  if filepath == "" then
    vim.notify("Không tìm thấy file: " .. cfile, vim.log.levels.ERROR)
    return
  end

  local current_win = vim.api.nvim_get_current_win()
  vim.cmd("wincmd h")

  if vim.api.nvim_get_current_win() == current_win then
    vim.notify("Không có cửa sổ bên trái!", vim.log.levels.WARN)
    return
  end

  vim.cmd("edit " .. vim.fn.fnameescape(filepath))
end, { desc = "Mở file tồn tại sang window bên trái" })

vim.keymap.set("v", "<leader>yl", function()
  -- Lấy số dòng bắt đầu và kết thúc của vùng chọn
  local start_line = vim.fn.line("v")
  local end_line = vim.fn.line(".")
  if start_line > end_line then
    start_line, end_line = end_line, start_line
  end

  -- Lấy đường dẫn file tương đối
  local file_path = vim.fn.expand("%:.")

  -- Lấy nội dung text trong vùng chọn
  local lines = vim.fn.getregion(vim.fn.getpos("v"), vim.fn.getpos("."), { type = vim.fn.mode() })
  local content = table.concat(lines, "\n")

  -- Định dạng chuỗi kết quả: file:start-end + nội dung
  local header = string.format("%s:%d-%d", file_path, start_line, end_line)
  if start_line == end_line then
    header = string.format("%s:%d", file_path, start_line)
  end

  local result = string.format("%s\n```\n%s\n```", header, content)

  -- Ném vào register hệ thống (+) để dán ra ngoài
  vim.fn.setreg("+", result)
  vim.notify("Copied: " .. header, vim.log.levels.INFO)
end, { desc = "Yank with file location" })
