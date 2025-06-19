return {
  "mason-org/mason.nvim",
  opts = function(_, opts)
    local values_to_remove = {
      ["phpcs"] = true,
      ["php-cs-fixer"] = true,
    }
    local new_ensure_installed = {}

    for _, v in ipairs(opts.ensure_installed) do
      if not values_to_remove[v] then
        table.insert(new_ensure_installed, v)
      end
    end

    opts.ensure_installed = new_ensure_installed
  end,
}
