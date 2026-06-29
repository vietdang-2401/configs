local function getcwd()
  local cwd = vim.fn.getcwd()
  return vim.fn.fnamemodify(cwd, ":t")
end

local function get_input_method()
  if vim.fn.executable("fcitx5-remote") == 0 then
    return "E"
  end

  local state = vim.trim(vim.fn.system("fcitx5-remote"))
  local im_name = vim.trim(vim.fn.system("fcitx5-remote -n"))

  if state == "1" and im_name ~= "keyboard-us" then
    return "V"
  end

  return "E"
end

return {
  "nvim-lualine/lualine.nvim",
  opts = function(_, opts)
    -- Add total line count to lualine_x section
    table.insert(opts.sections.lualine_x, {
      function()
        return "Lines: " .. vim.fn.line("$")
      end,
      color = { fg = "#ffaa00" }, -- Optional: set color
    })
    table.insert(opts.sections.lualine_z, {
      function()
        return os.date("%d-%m")
      end,
      color = { fg = "#000000" }, -- Optional: set color
    })
    -- table.insert(opts.sections.lualine_z, {
    --   get_input_method,
    --   color = { fg = "#000000" },
    -- })
    if os.getenv("SSH_CONNECTION") then
      table.insert(opts.sections.lualine_z, {
        function()
          return "SSH"
        end,
        color = { fg = "#ff0000" }, -- Optional: set color
      })
    end
    table.insert(opts.sections.lualine_b, 1, { getcwd })
    -- table.insert(opts.sections.lualine_b, 1, { "branch" })
  end,
}
