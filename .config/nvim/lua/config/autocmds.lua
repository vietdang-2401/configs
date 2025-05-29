-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

local uv = vim.loop

local function find_file_bfs(start_path, target_name)
  local queue = { start_path }

  while #queue > 0 do
    local current_dir = table.remove(queue, 1)
    local fs = uv.fs_scandir(current_dir)
    if fs then
      while true do
        local name, type = uv.fs_scandir_next(fs)
        if not name then
          break
        end

        local full_path = current_dir .. "/" .. name

        if type == "file" and name == target_name then
          return current_dir
        elseif type == "directory" then
          table.insert(queue, full_path)
        end
      end
    end
  end

  return nil
end

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

-- Hàm khởi động Laravel & Vue server
local function start_laravel_vue()
  if not is_running(laravel_jobs.serve) then
    local laravelFolder = find_file_bfs(vim.fn.getcwd(), "composer.json")
    laravel_jobs.serve = vim.fn.jobstart({ "php", "artisan", "serve" }, {
      cwd = laravelFolder,
    })
    notify("🚀 php artisan serve started")
  else
    notify("✅ php artisan serve đã chạy rồi!")
  end

  if not is_running(laravel_jobs.npm) then
    local vueFolder = find_file_bfs(vim.fn.getcwd(), "package.json")
    laravel_jobs.npm = vim.fn.jobstart({ "npm", "run", "dev" }, {
      cwd = vueFolder,
    })
    notify("🚀 npm run dev started")
  else
    notify("✅ npm run dev đã chạy rồi!")
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
