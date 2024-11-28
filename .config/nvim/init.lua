-- init.lua
-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

-- Set leader key (MUST come before lazy setup)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Setup lazy.nvim with your plugins
require("lazy").setup("config.plugins")

local lsp_zero = require('lsp-zero')
lsp_zero.preset({})

-- Configure LSP keybindings
lsp_zero.on_attach(function(client, bufnr)
    -- LSP keybindings
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
end)

-- Configure autocompletion
local cmp = require('cmp')
local cmp_select = { behavior = cmp.SelectBehavior.Select }

cmp.setup({
    mapping = cmp.mapping.preset.insert({
        ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
        ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
        ['<C-y>'] = cmp.mapping.confirm({ select = true }),
        ['<C-Space>'] = cmp.mapping.complete(),
    }),
    snippet = {
        expand = function(args)
            require('luasnip').lsp_expand(args.body)
        end,
    },
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
        { name = 'buffer' },
        { name = 'path' },
    }),
})

-- Setup Mason
require('mason').setup()
require('mason-lspconfig').setup({
    ensure_installed = {
        'lua_ls',        -- Lua
        'pyright',       -- Python
        'rust_analyzer', -- Rust
        'html',
        'cssls',
        'jsonls',
    },
    handlers = {
        lsp_zero.default_setup,
    },
})

-- Must be called after mason setup
lsp_zero.setup()

-- Ensure LSP formatting on save
vim.cmd [[autocmd BufWritePre * lua vim.lsp.buf.format()]]

require("config.options") -- Vim options
require("config.keymaps") -- Key mappings

-- General options
vim.opt.number = true         -- Show line numbers
vim.opt.relativenumber = true -- Show relative line numbers
vim.opt.termguicolors = true  -- Enable true colors support
vim.opt.mouse = 'a'           -- Enable mouse support

-- Text wrapping for specific file types
vim.api.nvim_create_autocmd("FileType", {
    pattern = { "markdown", "txt", "text", "tex" },
    callback = function()
        vim.opt_local.wrap = true        -- Enable line wrapping
        vim.opt_local.linebreak = true   -- Break lines at word boundaries
        vim.opt_local.breakindent = true -- Preserve indentation
        -- For prose-friendly editing
        vim.opt_local.spell = true       -- Enable spell checking
        vim.opt_local.conceallevel = 2   -- Hide markup syntax
    end
})

-- Code files stay unwrapped
vim.api.nvim_create_autocmd("FileType", {
    pattern = { "python", "lua", "javascript", "typescript" },
    callback = function()
        vim.opt_local.wrap = false
        vim.opt_local.number = true
        vim.opt_local.relativenumber = true
    end
})

-- Tmux compatibility
vim.opt.termguicolors = true
if vim.env.TMUX then
    vim.opt.clipboard = 'unnamedplus'
end


-- Setting keybindings
vim.keymap.set('n', '<A-Up>', ':m .-2<CR>==', { silent = true })
vim.keymap.set('n', '<A-Down>', ':m .+1<CR>==', { silent = true })
vim.keymap.set('v', '<A-Up>', ":m '<-2<CR>gv=gv", { silent = true })
vim.keymap.set('v', '<A-Down>', ":m '>+1<CR>gv=gv", { silent = true })

-- Alt+Shift+Up/Down to duplicate lines
vim.keymap.set('n', '<A-S-Up>', 'yyP', { silent = true })
vim.keymap.set('n', '<A-S-Down>', 'yyp', { silent = true })
vim.keymap.set('v', '<A-S-Up>', 'y`>p', { silent = true })
vim.keymap.set('v', '<A-S-Down>', 'y`>p', { silent = true })

-- Then add these keybindings
vim.g.VM_maps = {
    ['Find Under'] = '<C-A-d>',         -- Cmd+Alt+d
    ['Find Subword Under'] = '<C-A-d>', -- Cmd+Alt+d
    ['Select All'] = '<C-A-n>',         -- Cmd+Alt+n
    ['Select h'] = '<C-A-Left>',        -- Cmd+Alt+Left
    ['Select l'] = '<C-A-Right>',       -- Cmd+Alt+Right
}
