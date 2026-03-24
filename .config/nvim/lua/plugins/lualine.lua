local function getcwd()
  local cwd = vim.fn.getcwd()
  return vim.fn.fnamemodify(cwd, ":t")
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
    table.insert(opts.sections.lualine_b, 1, { getcwd })
    -- table.insert(opts.sections.lualine_b, 1, { "branch" })
  end,
}
