return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    local status_ok, harpoon = pcall(require, "harpoon")
    if not status_ok then
      return
    end
    harpoon:setup()

    -- picker
    local function generate_harpoon_picker()
      local file_paths = {}
      for _, item in ipairs(harpoon:list().items) do
        local entry = {
          text = item.value,
          file = item.value,
        }
        table.insert(file_paths, entry)
      end
      -- Snacks.debug.log(file_paths)
      return file_paths
    end
    -- vim.keymap.set("n", "<leader>a", function()
    --   harpoon:list():add()
    -- end)
    vim.keymap.set("n", "<leader>fh", function()
      Snacks.picker({
        finder = generate_harpoon_picker,
        win = {
          input = {
            keys = {
              ["dd"] = { "harpoon_delete", mode = { "n", "x" } },
            },
          },
          list = {
            keys = {
              ["dd"] = { "harpoon_delete", mode = { "n", "x" } },
            },
          },
        },
        actions = {
          harpoon_delete = function(picker, item)
            local to_remove = item or picker:selected()
            table.remove(harpoon:list().items, to_remove.idx)
            picker:find({
              refresh = true, -- refresh picker after removing values
            })
          end,
        },
      })
    end, { desc = "Harpoon picker" })
  end,
}
