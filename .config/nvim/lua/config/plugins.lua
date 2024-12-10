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
                defaults = {
                    file_ignore_patterns = {
                        "%.pyc",
                        "%.pyo",
                        "%.pyd",
                        "__pycache__/",
                        "%.cache",
                        "%.git/",
                        "%.ipynb_checkpoints/",
                        "node_modules/",
                        "%.dll",
                        "%.class",
                        "%.exe",
                        "%.o",
                        "%.a",
                        "%.out",
                        "%.pdf",
                        "%.mkv",
                        "%.mp4",
                        "%.zip",
                    }
                },
                pickers = {
                    find_files = {
                        -- hidden = true,
                        no_ignore = true  -- This will show files in .gitignore as well
                    },
                    live_grep = {
                        previewer = false,
                    -- hidden = true     -- This enables searching in hidden files
                    }
                }
            })
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
        },
        config = function()
            local lsp = require('lsp-zero').preset({})

            lsp.on_attach(function(client, bufnr)
                -- see :help lsp-zero-keybindings
                -- to learn the available actions
                lsp.default_keymaps({buffer = bufnr})
            end)

            -- Configure mason to automatically install LSP servers
            require('mason').setup({})
            require('mason-lspconfig').setup({
                ensure_installed = {
                    'pyright',  -- Python LSP
                    'lua_ls',   -- Lua LSP
                },
                handlers = {
                    lsp.default_setup,
                }
            })

            -- Configure completion
            local cmp = require('cmp')
            local cmp_select = {behavior = cmp.SelectBehavior.Select}

            cmp.setup({
                mapping = cmp.mapping.preset.insert({
                    ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
                    ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
                    ['<C-y>'] = cmp.mapping.confirm({ select = true }),
                    ['<C-Space>'] = cmp.mapping.complete(),
                })
            })

            lsp.setup()
        end
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
    -- {
    --     "folke/noice.nvim",
    --     event = "VeryLazy",
    --     dependencies = {
    --       "MunifTanjim/nui.nvim",
    --       "rcarriga/nvim-notify",
    --     },
    -- },

    -- Jupyter Notebook Support
    {
        "dccsillag/magma-nvim",
        build = ":UpdateRemotePlugins",
        config = function()
            -- Magma configuration
            vim.g.magma_automatically_open_output = true
            vim.g.magma_image_provider = "kitty"
            
            -- Keymaps for Jupyter notebook operations
            vim.keymap.set("n", "<leader>je", ":MagmaEvaluateOperator<CR>", { silent = true, desc = "Evaluate Operator" })
            vim.keymap.set("n", "<leader>jl", ":MagmaEvaluateLine<CR>", { silent = true, desc = "Evaluate Line" })
            vim.keymap.set("x", "<leader>jv", ":<C-u>MagmaEvaluateVisual<CR>", { silent = true, desc = "Evaluate Visual Selection" })
            vim.keymap.set("n", "<leader>jc", ":MagmaReevaluateCell<CR>", { silent = true, desc = "Reevaluate Cell" })
            vim.keymap.set("n", "<leader>jd", ":MagmaDelete<CR>", { silent = true, desc = "Delete Output" })
            vim.keymap.set("n", "<leader>jo", ":MagmaShowOutput<CR>", { silent = true, desc = "Show Output" })
            vim.keymap.set("n", "<leader>ji", ":MagmaInit<CR>", { silent = true, desc = "Initialize Kernel" })
        end,
    },

    {
        "goerz/jupytext.vim",
        lazy = false,
        init = function()
            -- Configure jupytext to automatically sync .ipynb with .py files
            vim.g.jupytext_fmt = 'py:percent'
            vim.g.jupytext_style = 'hydrogen'
        -- Enable automatic synchronization
        vim.g.jupytext_sync_always = 1
        -- Automatically convert ipynb files when reading/writing
        vim.g.jupytext_enable_custom_codecells = 1
        vim.g.jupytext_command = 'jupytext'
        -- Set the filetype for .ipynb files
        vim.cmd([[
            augroup jupyter_notebooks
                autocmd!
                autocmd BufRead,BufNewFile *.ipynb set filetype=python
                autocmd BufRead,BufNewFile *.ipynb setlocal conceallevel=0
            augroup END
        ]])
        end
    },

    -- Avante:
   {
      "yetone/avante.nvim",
      event = "VeryLazy",
      version = false, -- latest changes
      opts = {
        -- config will go in setup()
      },
      build = "make",
      dependencies = {
        "stevearc/dressing.nvim",
        "nvim-lua/plenary.nvim",
        "MunifTanjim/nui.nvim",
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

    -- GitHub Copilot
    {
        "github/copilot.vim",
        cmd = "Copilot",
        event = "InsertEnter",
        config = function()
            -- Disable copilot by default (enable with :Copilot enable)
            vim.g.copilot_enabled = true
            -- Disable default tab mapping for acceptance
             -- vim.g.copilot_no_tab_map = true
        end
    },

    -- Auto-save
    {
        "pocco81/auto-save.nvim",
        config = function()
            require("auto-save").setup({
                enabled = true,
                execution_message = {
                    message = function() return ("AutoSave: saved at " .. vim.fn.strftime("%H:%M:%S")) end,
                    dim = 0.18,
                    cleaning_interval = 1250,
                },
                trigger_events = {"InsertLeave", "TextChanged"},
                -- Function to determine whether to save
                condition = function(buf)
                    local fn = vim.fn.expand("%:t")
                    local utils = require("auto-save.utils.data")
                    if fn ~= "" and utils.not_in(fn, {}) then
                        return true
                    end
                    return false
                end,
                write_all_buffers = false,
                debounce_delay = 135,
            })
        end
    },
}
