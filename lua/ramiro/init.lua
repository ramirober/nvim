-- Leader mapping (space)
vim.g.mapleader = " "

-- Set the number of spaces a <Tab> counts for while performing editing operations
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
-- Set the number of spaces to use for each step of (auto)indent
vim.opt.shiftwidth = 2
-- Use the appropriate number of spaces to insert a <Tab>
vim.opt.expandtab = true

-- Smart indent: do smart autoindenting when starting a new line
vim.opt.smartindent = true

vim.opt.wrap = false

-- Enable line numbers
vim.opt.nu = true
-- Enable relative line numbers
vim.opt.relativenumber = true

vim.opt.termguicolors = true

vim.o.signcolumn = "yes"

-- Keybind for switching between last two opened files
vim.keymap.set("n", "<leader><leader>", "<C-^>")

-- Use system clipboard
vim.api.nvim_set_option("clipboard", "unnamed")
