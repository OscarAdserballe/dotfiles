-- lua/config/keymaps.lua
local keymap = vim.keymap

-- Set leader key
vim.g.mapleader = " "

-- General keymaps
keymap.set("n", "<leader>pv", vim.cmd.Ex)  -- File explorer
keymap.set("n", "<leader>w", ":w<CR>")     -- Save
keymap.set("n", "<leader>q", ":q<CR>")     -- Quit

-- Split window navigation
keymap.set("n", "<C-h>", "<C-w>h")
keymap.set("n", "<C-j>", "<C-w>j")
keymap.set("n", "<C-k>", "<C-w>k")
keymap.set("n", "<C-l>", "<C-w>l")

-- Telescope
keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>")
keymap.set("n", "<leader>fs", "<cmd>Telescope live_grep<cr>")
keymap.set("n", "<leader>fc", "<cmd>Telescope grep_string<cr>")
keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>")
keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<cr>")

-- Undotree
keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)

-- Git
keymap.set("n", "<leader>gs", vim.cmd.Git)
