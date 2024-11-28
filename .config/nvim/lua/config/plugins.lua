-- lua/config/plugins.lua
return {
    -- Essential plugins
    {
        "nvim-telescope/telescope.nvim",
        dependencies = { "nvim-lua/plenary.nvim" }
    },
    { "nvim-treesitter/nvim-treesitter" },
    { "ThePrimeagen/harpoon" },
    { "mbbill/undotree" },
    { "tpope/vim-fugitive" },

    -- LSP
    {
        "VonHeikemen/lsp-zero.nvim",
        branch = "v2.x",
        dependencies = {
            -- LSP Support
            { "neovim/nvim-lspconfig" },
            { "williamboman/mason.nvim" },
            { "williamboman/mason-lspconfig.nvim" },

            -- Autocompletion
            { "hrsh7th/nvim-cmp" },
            { "hrsh7th/cmp-buffer" },
            { "hrsh7th/cmp-path" },
            { "saadparwaiz1/cmp_luasnip" },
            { "hrsh7th/cmp-nvim-lsp" },
            { "hrsh7th/cmp-nvim-lua" },

            -- Snippets
            { "L3MON4D3/LuaSnip" },
            { "rafamadriz/friendly-snippets" },
        }
    },
    {
        "shaunsingh/solarized.nvim",
        config = function()
            vim.cmd("colorscheme solarized")
        end,
    },
    {
        "nvim-telescope/telescope.nvim",
        dependencies = { "nvim-lua/plenary.nvim" }
    },
    { "nvim-treesitter/nvim-treesitter" },
    { "ThePrimeagen/harpoon" },
    { "mbbill/undotree" },
    { "tpope/vim-fugitive" },

    -- Add these LSP plugins
    {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "neovim/nvim-lspconfig",
    },

    -- Add LSP Zero for easier setup
    {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v2.x',
        dependencies = {
            -- LSP Support
            { 'neovim/nvim-lspconfig' },             -- Required
            { 'williamboman/mason.nvim' },           -- Optional
            { 'williamboman/mason-lspconfig.nvim' }, -- Optional

            -- Autocompletion
            { 'hrsh7th/nvim-cmp' },     -- Required
            { 'hrsh7th/cmp-nvim-lsp' }, -- Required
            { 'L3MON4D3/LuaSnip' },     -- Required
        }
    },
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function()
            require("nvim-treesitter.configs").setup({
                ensure_installed = {
                    "python",
                    "lua",
                    "vim",
                    "javascript",
                    "typescript",
                    "json",
                    "html",
                    "css",
                    "markdown",
                    "bash"
                },
                highlight = {
                    enable = true,
                    additional_vim_regex_highlighting = false,
                },
                indent = { enable = true },
                incremental_selection = {
                    enable = true,
                    keymaps = {
                        init_selection = "<CR>",
                        node_incremental = "<CR>",
                        node_decremental = "<BS>",
                        scope_incremental = "<TAB>",
                    },
                },
            })
        end
    },
    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        config = function()
            require("nvim-autopairs").setup({
                enable_check_bracket_line = true,
                check_ts = true, -- treesitter integration
                ts_config = {
                    lua = { 'string' },
                    java = false,
                },
                fast_wrap = {
                    map = '<M-e>',
                    chars = { '{', '[', '(', '"', "'" },
                    pattern = [=[[%'%"%>%]%)%}%,]]=],
                    end_key = '$',
                    keys = 'qwertyuiopzxcvbnmasdfghjkl',
                    check_comma = true,
                    highlight = 'Search',
                    highlight_grey = 'Comment'
                },
            })
        end
    },
    {
        "tpope/vim-surround", -- Allows you to surround text with pairs
    },
    {
        "lervag/vimtex",                         -- Enhanced LaTeX support
        config = function()
            vim.g.vimtex_view_method = 'zathura' -- or 'skim' on macOS
            vim.g.vimtex_quickfix_mode = 0
            -- Latex warnings to ignore
            vim.g.vimtex_quickfix_ignore_filters = {
                'Underfull',
                'Overfull',
            }
        end
    },
    {
        "christoomey/vim-tmux-navigator",
        lazy = false, -- Load immediately
    },
    {
        "ThePrimeagen/harpoon",
        config = function()
            local mark = require("harpoon.mark")
            local ui = require("harpoon.ui")

            -- Harpoon keymaps
            vim.keymap.set("n", "<leader>a", mark.add_file)
            vim.keymap.set("n", "<C-e>", ui.toggle_quick_menu)
            vim.keymap.set("n", "<C-h>", function() ui.nav_file(1) end)
            vim.keymap.set("n", "<C-j>", function() ui.nav_file(2) end)
            vim.keymap.set("n", "<C-k>", function() ui.nav_file(3) end)
            vim.keymap.set("n", "<C-l>", function() ui.nav_file(4) end)
        end,
        dependencies = { "nvim-lua/plenary.nvim" }
    },
    {
        "mg979/vim-visual-multi",
        event = "VeryLazy",
        config = function()
            -- These are better default mappings for Mac
            vim.g.VM_maps = {
                ['Find Under'] = '<C-d>',              -- Control-d (like VSCode)
                ['Find Subword Under'] = '<C-d>',      -- Control-d
                ['Select All'] = '<C-S-l>',            -- Control-Shift-l
                ['Add Cursor Up'] = '<C-S-Up>',        -- Control-Shift-Up
                ['Add Cursor Down'] = '<C-S-Down>',    -- Control-Shift-Down
                ['Add Cursor At Pos'] = '<C-S-Space>', -- Control-Shift-Space
                ['Start Regex Search'] = '<C-/>'       -- Control-/
            }
        end
    }
}
