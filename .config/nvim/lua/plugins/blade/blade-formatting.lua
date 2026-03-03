return {
  "stevearc/conform.nvim",
  opts = {
    formatters_by_ft = {
      php = { "laravel-pint" },
      blade = { "blade-formatter" },
    },
    formatters = {
      ["laravel-pint"] = {
        -- Tìm file pint trong thư mục vendor của dự án Laravel
        command = "vendor/bin/pint",
        condition = function(self, ctx)
          return vim.fs.find({ "vendor/bin/pint" }, { path = ctx.filename, upward = true })[1] ~= nil
        end,
      },
    },
  },
}
