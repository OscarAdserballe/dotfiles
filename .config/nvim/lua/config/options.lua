-- lua/config/options.lua
local opt = vim.opt

-- Line numbers
opt.relativenumber = true
opt.number = true

-- Tabs & indentation
opt.tabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.autoindent = true

-- Line wrapping
opt.wrap = false

-- Search settings
opt.ignorecase = true
opt.smartcase = true

-- Cursor line
opt.cursorline = true

-- Appearance
opt.signcolumn = "yes"

-- Clipboard
opt.clipboard:append("unnamedplus")

-- Split windows
opt.splitright = true
opt.splitbelow = true

-- Consider - as part of word
opt.iskeyword:append("-")

-- Disable swapfile
opt.swapfile = false

-- General Settings
vim.opt.termguicolors = true     -- Enable true colors support
vim.opt.number = true            -- Show line numbers
vim.opt.relativenumber = true    -- Show relative line numbers
vim.opt.mouse = 'a'             -- Enable mouse support

-- Cursor settings
vim.opt.guicursor = "n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50"  -- Different cursor shapes for different modes
vim.opt.cursorline = true    -- Highlight the current line

vim.api.nvim_set_hl(0, 'CursorNormal', { bg = '#EF9F76', fg = '#303446' })
vim.api.nvim_set_hl(0, 'CursorInsert', { bg = '#A6D189', fg = '#303446' })

-- Text wrapping for specific file types
vim.api.nvim_create_autocmd("FileType", {
    pattern = { "markdown", "txt", "text", "tex", "latex", "plaintex" },
    callback = function()
        vim.opt_local.wrap = true        -- Enable line wrapping
        vim.opt_local.linebreak = true   -- Break lines at word boundaries
        vim.opt_local.breakindent = true -- Preserve indentation
        vim.opt_local.spell = true       -- Enable spell checking
        vim.opt_local.conceallevel = 2   -- Hide markup syntax
    end
})

vim.api.nvim_create_autocmd({"BufRead", "BufNewFile"}, {
    pattern = {"*.tex", "*.sty", "*.cls", "*.bib"},
    callback = function()
        vim.opt_local.wrap = true
        vim.opt_local.linebreak = true
        vim.opt_local.breakindent = true
        vim.opt_local.spell = true
        vim.opt_local.conceallevel = 2
        -- Force the filetype to be tex if not already set
        if vim.bo.filetype ~= "tex" then
            vim.bo.filetype = "tex"
        end
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
if vim.env.TMUX then
    vim.opt.clipboard = 'unnamedplus'
end
