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

-- Line movement
vim.keymap.set('n', '<A-Up>', ':m .-2<CR>==', { silent = true })
vim.keymap.set('n', '<A-Down>', ':m .+1<CR>==', { silent = true })
vim.keymap.set('v', '<A-Up>', ":m '<-2<CR>gv=gv", { silent = true })
vim.keymap.set('v', '<A-Down>', ":m '>+1<CR>gv=gv", { silent = true })

-- Line duplication
vim.keymap.set('n', '<A-S-Up>', 'yyP', { silent = true })
vim.keymap.set('n', '<A-S-Down>', 'yyp', { silent = true })
vim.keymap.set('v', '<A-S-Up>', 'y`>p', { silent = true })
vim.keymap.set('v', '<A-S-Down>', 'y`>p', { silent = true })

-- LSP keybindings (moved from init.lua)
local function setup_lsp_keymaps(client, bufnr)
    local opts = { buffer = bufnr, remap = false }
    vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
    vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
    vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
    vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
    vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
    vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
    vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
    vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
    vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
    vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
end

-- Export the setup function for use in LSP configuration
return {
    setup_lsp_keymaps = setup_lsp_keymaps
}
