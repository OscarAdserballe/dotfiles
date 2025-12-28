-- lua/config/keymaps.lua
local keymap = vim.keymap

-- Set leader key
vim.g.mapleader = " "

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
vim.keymap.set("n", "<leader>fn", ":Telescope find_files cwd=~/Google\\ Drive/My\\ Drive/Obsidian<CR>")
vim.keymap.set("n", "<leader>fg", ":Telescope live_grep cwd=~/Google\\ Drive/My\\ Drive/Obsidian<CR>")
vim.keymap.set("n", "<leader>fl", ":Telescope find_files cwd=~/Google\\ Drive/My\\ Drive/llm_sessions<CR>")

-- Obsidian keymaps
vim.keymap.set("n", "<leader>fp", ":ObsidianNew<CR>") -- regular new note
vim.keymap.set("n", "<leader>fd", ":ObsidianToday<CR>") -- daily note
vim.keymap.set("n", "<leader>fy", ":ObsidianYesterday<CR>") --yesterday's daily note
vim.keymap.set("n", "<leader>ft", ":ObsidianTomorrow<CR>") -- tomorrow's daily note

-- Undotree
keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)

-- Git
keymap.set("n", "<leader>gs", vim.cmd.Git)

-- Toggle NeoTree 
vim.keymap.set('n', '<leader>s', ':Neotree toggle<CR>', { silent = true })
vim.keymap.set('n', '<leader>b', ':Neotree toggle<CR>', { noremap = true })

-- LLM Integration
vim.keymap.set('n', '<leader>ll', function() require('llm_integration').run_llm_session("file") end, { noremap = true, silent = false, desc = "Run LLM File" })
vim.keymap.set("n", "<leader>ls", ":edit ~/Google\\ Drive/My\\ Drive//llm_sessions/base/base.md<CR>", {
  noremap = true,
  silent = true,
  desc = "Open a base-llm",
})

-- Copilot overriding keymap
-- vim.keymap.set('i', '<C-j>', 'copilot#Accept("\\<CR>")', {
--     expr = true,
--     replace_keycodes = false
-- })
-- vim.g.copilot_no_tab_map = true


-- NOTE: We don't want to use { and } to navigate anymore, so removing those keymaps.
vim.keymap.set('n', '{', '', { noremap = true, silent = true })
vim.keymap.set('v', '{', '', { noremap = true, silent = true })
vim.keymap.set('n', '}', '', { noremap = true, silent = true })
vim.keymap.set('v', '}', '', { noremap = true, silent = true })

-- Center search results
vim.keymap.set('n', 'n', 'nzz', { noremap = true, silent = true })
vim.keymap.set('n', 'N', 'Nzz', { noremap = true, silent = true })

-- Center cursor when navigating with bufferwindow 
vim.keymap.set('n', '<C-u>', '<C-u>zz', { noremap = true, silent = true })
vim.keymap.set('v', '<C-u>', '<C-u>zz', { noremap = true, silent = true })
vim.keymap.set('n', '<C-d>', '<C-d>zz', { noremap = true, silent = true })
vim.keymap.set('v', '<C-d>', '<C-d>zz', { noremap = true, silent = true })

-- Preserve buffer when pasting using space p
vim.keymap.set('n', '<leader>p', '"_dP', { noremap = true, silent = true, desc = "Paste without changing default register" })
vim.keymap.set('v', '<leader>p', '"_dP', { noremap = true, silent = true, desc = "Paste without changing default register" })

-- Export the setup function for use in LSP configuration
return {
    setup_lsp_keymaps = setup_lsp_keymaps
}

