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
