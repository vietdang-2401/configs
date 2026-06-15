-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
vim.g.snacks_animate = false
vim.o.showtabline = 0

-- LSP Server to use for PHP.
-- Set to "intelephense" to use intelephense instead of phpactor.
vim.g.lazyvim_php_lsp = "intelephense"
vim.g.root_spec = { ".git", "README.md" }

vim.opt.clipboard = "unnamedplus"

vim.cmd([[cab cc CodeCompanion]])

vim.api.nvim_set_keymap("t", "<C-j>", [[<C-\><C-n>]], { noremap = true, silent = true })
