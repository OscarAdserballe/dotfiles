return {
    -- Color scheme
    {
        "catppuccin/nvim",
        name = "catppuccin",
        priority = 1000,
        config = function()
            require("catppuccin").setup({
                flavour = "mocha",
                background = {
                    light = "frappe",
                    dark = "frappe",
                },
                transparent_background = false,
                term_colors = true,
                integrations = {
                    cmp = true,
                    gitsigns = true,
                    nvimtree = true,
                    telescope = true,
                    treesitter = true,
                    mason = true,
                    which_key = true,
                    indent_blankline = {
                        enabled = true,
                        colored_indent_levels = false,
                    },
                    native_lsp = {
                        enabled = true,
                        virtual_text = {
                            errors = { "italic" },
                            hints = { "italic" },
                            warnings = { "italic" },
                            information = { "italic" },
                        },
                        underlines = {
                            errors = { "underline" },
                            hints = { "underline" },
                            warnings = { "underline" },
                            information = { "underline" },
                        },
                    },
                },
            })
            
            vim.cmd.colorscheme "catppuccin"   
            vim.api.nvim_set_hl(0, "Cursor", { bg = "#F4B8E4" })
            vim.api.nvim_set_hl(0, "CursorLine", { bg = "#303446" })
        end,
    },

    -- Telescope
    {
        "nvim-telescope/telescope.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            local telescope = require('telescope')
            telescope.setup({
                pickers = {
                    live_grep = {
                        previewer = false
                    }
                }
            })
            -- Add keymaps for research workflow
            vim.keymap.set("n", "<leader>fn", ":Telescope find_files cwd=~/OneDrive/Obsidian<CR>")
            vim.keymap.set("n", "<leader>fg", ":Telescope live_grep cwd=~/OneDrive/Obsidian<CR>")
        end
    },

    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function()
            require("nvim-treesitter.configs").setup({
                ensure_installed = {
                    "python", "lua", "vim", "javascript",
                    "typescript", "json", "html", "css",
                    "markdown", "bash"
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
        "ThePrimeagen/harpoon",
        config = function()
            local mark = require("harpoon.mark")
            local ui = require("harpoon.ui")

            vim.keymap.set("n", "<leader>a", mark.add_file)
            vim.keymap.set("n", "<C-e>", ui.toggle_quick_menu)
            vim.keymap.set("n", "<C-h>", function() ui.nav_file(1) end)
            vim.keymap.set("n", "<C-j>", function() ui.nav_file(2) end)
            vim.keymap.set("n", "<C-k>", function() ui.nav_file(3) end)
            vim.keymap.set("n", "<C-l>", function() ui.nav_file(4) end)
        end,
        dependencies = { "nvim-lua/plenary.nvim" }
    },
    { "mbbill/undotree" },
    { "tpope/vim-fugitive" },

    -- LSP and completion
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

    -- Editor enhancements
    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        config = function()
            require("nvim-autopairs").setup({
                enable_check_bracket_line = true,
                check_ts = true,
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
    { "tpope/vim-surround" },

       -- Terminal/tmux integration
    {
        "christoomey/vim-tmux-navigator",
        lazy = false,
    },

    -- Markdown
    {
        "preservim/vim-markdown",
        config = function()
            -- Enable conceal for prettier markdown
            vim.g.vim_markdown_conceal = 1
            vim.g.vim_markdown_folding_disabled = 1
            -- Enable YAML frontmatter
            vim.g.vim_markdown_frontmatter = 1
        end
    },
    {
        "iamcco/markdown-preview.nvim",
        cmd = { "MarkdownPreview", "MarkdownPreviewToggle" },
        build = function() vim.fn["mkdp#util#install"]() end,
    },

    -- Obsidian
    {
        "epwalsh/obsidian.nvim",
        lazy = false,
        event = {
            "BufReadPre " .. vim.fn.expand "~" .. "OneDrive/Obsidian/**.md",
            "BufNewFile " .. vim.fn.expand "~" .. "OneDrive/Obsidian/**.md",
        },
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        config = function()
            require("obsidian").setup({
                dir = "~/OneDrive/Obsidian",  -- Change this to your vault path
                notes_subdir = "Quick Notes",
                note_id_func = function(title)
                    -- Convert the title to a valid filename
                    local suffix = ""
                    if title ~= nil then
                        -- Clean title and convert to lowercase
                        suffix = title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
                    else
                        -- If no title provided, use date
                        suffix = os.date("%Y-%m-%d-%H%M%S")
                end
                return suffix
            end,
                daily_notes = {
                    folder = "Daily",
                    date_format = "%Y-%m-%d"
                },
                completion = {
                    nvim_cmp = true,
                    min_chars = 2,
                },
                templates = {
                    subdir = "Templates",
                    date_format = "%Y-%m-%d",
                    time_format = "%H:%M",
                },
                -- Enable WikiLinks [[Links]]
                disable_frontmatter = false,
                note_frontmatter_func = nil,
                follow_url_func = nil,
                use_advanced_uri = true,
            })

            -- Key mappings for Obsidian features
            vim.keymap.set("n", "gf", function()
                if require("obsidian").util.cursor_on_markdown_link() then
                    return "<cmd>ObsidianFollowLink<CR>"
                else
                    return "gf"
                end
            end, { noremap = false, expr = true })

            vim.keymap.set("n", "<leader>fp", ":ObsidianNew<CR>")
        end
    },
    -- CmdLine Plugin
    {
        "folke/noice.nvim",
        event = "VeryLazy",
        dependencies = {
          "MunifTanjim/nui.nvim",
          "rcarriga/nvim-notify",
        },
    },

    -- Avante:
   {
      "yetone/avante.nvim",
      event = "VeryLazy",
      lazy = false,
      version = false, -- latest changes
      opts = {
        -- config will go in setup()
      },
      build = "make",
      dependencies = {
        "stevearc/dressing.nvim",
        "nvim-lua/plenary.nvim",
        "MunifTanjim/nui.nvim",
        -- Optional but recommended dependencies
        "hrsh7th/nvim-cmp",
        "nvim-tree/nvim-web-devicons",
        {
          "HakonHarnes/img-clip.nvim",
          event = "VeryLazy",
          opts = {
            default = {
              embed_image_as_base64 = false,
              prompt_for_file_name = false,
              drag_and_drop = {
                insert_mode = true,
              },
              use_absolute_path = true,
            },
          },
        },
      },
    },

    -- Magma for Jupyter Notebook integration
    {
        "dccsillag/magma-nvim",
        build = ":UpdateRemotePlugins",
        lazy = false,
        config = function()
            -- Basic configuration
            vim.g.magma_automatically_open_output = false
            
            -- Essential keymaps
            vim.keymap.set('n', '<Leader>r', ':MagmaEvaluateLine<CR>', { silent = true })
            vim.keymap.set('x', '<Leader>r', ':<C-u>MagmaEvaluateVisual<CR>', { silent = true })
            vim.keymap.set('n', '<Leader>ro', ':MagmaShowOutput<CR>', { silent = true })
        end,
    },

}
