-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

-- Module lưu các job Laravel
local laravel_jobs = {
  serve = nil,
  npm = nil,
}

local function notify(text)
  vim.schedule(function()
    vim.notify(text, vim.log.levels.INFO)
  end)
end

-- Hàm kiểm tra job có đang chạy không
local function is_running(job_id)
  if job_id == nil then
    return false
  end
  local status = vim.fn.jobwait({ job_id }, 0)[1]
  return status == -1 -- -1: job còn đang chạy
end

-- Hàm khởi động Laravel
local function start_laravel_vue()
  if vim.fn.filereadable("artisan") == 0 then
    notify("Không phải thư mục Laravel.")
    return
  end

  if not is_running(laravel_jobs.serve) then
    laravel_jobs.serve = vim.fn.jobstart({ "php", "artisan", "serve" }, {
      cwd = vim.fn.getcwd(),
    })
    notify("🚀 php artisan serve started")
  else
    notify("✅ php artisan serve đang chạy")
  end

  if not is_running(laravel_jobs.npm) then
    laravel_jobs.npm = vim.fn.jobstart({ "npm", "run", "dev" }, {
      cwd = vim.fn.getcwd(),
    })
    notify("🚀 npm run dev started")
  else
    notify("✅ npm run dev đang chạy")
  end
end

local function stop_laravel_vue()
  if laravel_jobs.serve then
    vim.fn.jobstop(laravel_jobs.serve)
    notify("Stopped php artisan serve")
  end
  if laravel_jobs.npm then
    vim.fn.jobstop(laravel_jobs.npm)
    notify("Stopped npm run dev")
  end
end

-- Lệnh thủ công
vim.api.nvim_create_user_command("DevStart", start_laravel_vue, {})
vim.api.nvim_create_user_command("DevStop", stop_laravel_vue, {})
vim.api.nvim_create_user_command("DevRestart", function()
  stop_laravel_vue()
  vim.defer_fn(start_laravel_vue, 2000)
end, {})

-- Tự chạy khi vào Neovim
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    start_laravel_vue()
  end,
})

vim.api.nvim_create_autocmd("VimLeavePre", {
  callback = function()
    stop_laravel_vue()
  end,
})
