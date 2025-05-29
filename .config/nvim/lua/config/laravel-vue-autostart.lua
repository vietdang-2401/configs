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
  if not is_running(laravel_jobs.serve) then
    laravel_jobs.serve = vim.fn.jobstart({ "php", "artisan", "serve" }, {
      cwd = vim.fn.getcwd() .. "/backend",
    })
    notify("🚀 php artisan serve started")
  else
    notify("✅ php artisan serve is running")
  end

  if not is_running(laravel_jobs.npm) then
    laravel_jobs.npm = vim.fn.jobstart({ "npm", "run", "dev" }, {
      cwd = vim.fn.getcwd() .. "/frontend",
    })
    notify("🚀 npm run dev started")
  else
    notify("✅ npm run dev is running")
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
vim.api.nvim_create_user_command("DevCrmStart", start_laravel_vue, {})
vim.api.nvim_create_user_command("DevCrmStop", stop_laravel_vue, {})
