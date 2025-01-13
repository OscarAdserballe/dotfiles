return {
    -- Color scheme
    {
        "catppuccin/nvim",
        name = "catppuccin",
        priority = 1000,
        config = function()
            require("catppuccin").setup({
                flavour = "mocha", -- latte, frappe, macchiato, mocha
                transparent_background = false,
                term_colors = true,
                dim_inactive = {
                    enabled = true,
                    shade = "dark",
                    percentage = 0.25,
                },
                styles = {
                    comments = { "italic" },
                    conditionals = { "italic" },
                    loops = {},
                    functions = {},
                    keywords = {},
                    strings = {},
                    variables = {},
                    numbers = {},
                    booleans = {},
                    properties = {},
                    types = {},
                    operators = {},
                },
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
                        "%.png",
                        "%.jpg",
                        "%.jpeg",
                        "%.gif",
                        "%.svg",
                        "%.otf",
                        "%.ttf",
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
                        "%.log",
                        "%.txt",
                    }
                },
                pickers = {
                    find_files = {
                        -- hidden = true,
                        previewer = true,
                        no_ignore = true  -- This will show files in .gitignore as well
                    },
                    live_grep = {
                        previewer = true,
                    -- hidden = true     -- This enables searching in hidden files
                    }
                }
            })
            vim.keymap.set("n", "<leader>fn", ":Telescope find_files cwd=~/Google\\ Drive/My\\ Drive/Obsidian<CR>")
            vim.keymap.set("n", "<leader>fg", ":Telescope live_grep cwd=~/Google\\ Drive/My\\ Drive/Obsidian<CR>")
            vim.keymap.set("n", "<leader>fl", ":Telescope find_files cwd=~/Google\\ Drive/My\\ Drive/llm_sessions<CR>")
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
                    "markdown", "bash", "sql", "yaml"
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

            -- StarCraft style: leader+shift+number to mark, leader+number to navigate
            -- Mark files (Shift + number)
            vim.keymap.set("n", "<leader>!", function() mark.set_current_at(1); print("File 1 marked") end)
            vim.keymap.set("n", "<leader>@", function() mark.set_current_at(2); print("File 2 marked") end)
            vim.keymap.set("n", "<leader>#", function() mark.set_current_at(3); print("File 3 marked") end)
            vim.keymap.set("n", "<leader>$", function() mark.set_current_at(4); print("File 4 marked") end)
            vim.keymap.set("n", "<leader>%", function() mark.set_current_at(5); print("File 5 marked") end)
            vim.keymap.set("n", "<leader>^", function() mark.set_current_at(6); print("File 6 marked") end)
            vim.keymap.set("n", "<leader>&", function() mark.set_current_at(7); print("File 7 marked") end)
            vim.keymap.set("n", "<leader>*", function() mark.set_current_at(8); print("File 8 marked") end)
            vim.keymap.set("n", "<leader>(", function() mark.set_current_at(9); print("File 9 marked") end)
            vim.keymap.set("n", "<leader>)", function() mark.set_current_at(10); print("File 10 marked") end)

            -- Navigate to marked files (number)
            vim.keymap.set("n", "<leader>1", function() ui.nav_file(1) end)
            vim.keymap.set("n", "<leader>2", function() ui.nav_file(2) end)
            vim.keymap.set("n", "<leader>3", function() ui.nav_file(3) end)
            vim.keymap.set("n", "<leader>4", function() ui.nav_file(4) end)
            vim.keymap.set("n", "<leader>5", function() ui.nav_file(5) end)
            vim.keymap.set("n", "<leader>6", function() ui.nav_file(6) end)
            vim.keymap.set("n", "<leader>7", function() ui.nav_file(7) end)
            vim.keymap.set("n", "<leader>8", function() ui.nav_file(8) end)
            vim.keymap.set("n", "<leader>9", function() ui.nav_file(9) end)
            vim.keymap.set("n", "<leader>0", function() ui.nav_file(10) end)
            
            -- Keep quick menu for overview
            vim.keymap.set("n", "<C-e>", ui.toggle_quick_menu)
            
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

        lsp.on_attach(function(client, bufnr)
            -- Add this line to ensure Copilot works alongside LSP
            if client.name == "pyright" then
                client.server_capabilities.documentFormattingProvider = false
            end
            
            lsp.default_keymaps({buffer = bufnr})
        end)

            -- Configure mason to automatically install LSP servers
            require('mason').setup({})
            require('mason-lspconfig').setup({
                ensure_installed = {
                    'pyright',  -- Python LSP
                    'lua_ls',   -- Lua LSP
                    'sqlls',    -- SQL LSP
                    'emmet_ls', -- HTML/CSS/Jinja LSP
                },
                handlers = {
                    lsp.default_setup,
                ["lua_ls"] = function()
                    require('lspconfig').lua_ls.setup({
                        settings = {
                            Lua = {
                                diagnostics = {
                                    globals = { 'vim' }
                                },
                                workspace = {
                                    library = vim.api.nvim_get_runtime_file("", true),
                                    checkThirdParty = false,
                                },
                                telemetry = {
                                    enable = false,
                                },
                            },
                        },
                    })
                end,
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
        -- when to load the plugin: on specific events
        event = {
            "BufReadPre " .. vim.fn.expand "~" .. "/Google\\ Drive/My\\ Drive/Obsidian/**.md",
            "BufNewFile " .. vim.fn.expand "~" .. "/Google\\ Drive/My\\ Drive/Obsidian/**.md",
        },
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        config = function()
            require("obsidian").setup({
                dir = "~/Google Drive/My Drive/Obsidian",  -- Change this to your vault path
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

            -- Regular new note
            vim.keymap.set("n", "<leader>fp", ":ObsidianNew<CR>")
            -- Daily note
            vim.keymap.set("n", "<leader>fd", ":ObsidianToday<CR>")
            -- Open yesterday's daily note
            vim.keymap.set("n", "<leader>fy", ":ObsidianYesterday<CR>")
            -- Open tomorrow's daily note
            vim.keymap.set("n", "<leader>ft", ":ObsidianTomorrow<CR>")
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
            vim.g.copilot_enabled = true
            vim.g.copilot_filetypes = {
                ["*"] = true,
                ["python"] = true,
                ["markdown"] = true
            }
            
            -- Add this to debug Copilot's status
            vim.api.nvim_create_autocmd("FileType", {
                pattern = {"python", "markdown"},
                callback = function()
                    print(vim.bo.filetype .. " Copilot status: " .. vim.fn['copilot#Enabled']())
                end,
            })
        end
    },

    -- Lualine
    {
        'nvim-lualine/lualine.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        lazy = false,  -- Make sure it loads at startup
        config = function()
            vim.opt.laststatus = 3
            vim.opt.showmode = false    -- Disable default mode display
            vim.opt.ruler = false       -- Disable the ruler
            require('lualine').setup({
                options = {
                    theme = "catppuccin",
                    component_separators = { left = '', right = ''},
                    section_separators = { left = '', right = ''},
                    globalstatus = true,
                },
                sections = {
                    lualine_a = {
                        { 'mode', separator = { left = '' }, right_padding = 2 },
                    },
                    lualine_b = { 'branch', 'diff', 'diagnostics' },
                    lualine_c = {
                        { 'filename', path = 1 }
                    },
                    lualine_x = {
                        'encoding',
                        'fileformat',
                        'filetype'
                    },
                    lualine_y = { 'progress' },
                    lualine_z = {
                        { 'location', separator = { right = '' }, left_padding = 2 },
                    },
                },
                inactive_sections = {
                    lualine_a = {},
                    lualine_b = {},
                    lualine_c = { 'filename' },
                    lualine_x = { 'location' },
                    lualine_y = {},
                    lualine_z = {},
                },
                extensions = { 'fugitive', 'nvim-tree', 'toggleterm' },
            })
        end
    },
    -- Auto-save and auto-reload
    {
        "pocco81/auto-save.nvim",
        config = function()
            -- Set up autoread functionality
            vim.o.autoread = true
            -- Create an autocommand group for file change detection
            local auto_read_group = vim.api.nvim_create_augroup("AutoReloadFile", { clear = true })
            -- Create autocommands for file change detection
            vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter" }, {
                group = auto_read_group,
                pattern = "*",
                callback = function()
                    local ft = vim.bo.filetype
                    -- Only check for changes in non-special buffers
                    if ft ~= "" and ft ~= "neo-tree" and vim.fn.getcmdwintype() == "" then
                        vim.cmd("checktime")
                    end
                end,
            })

            -- Set up auto-save
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

    -- Auto-reload files
    {
        "famiu/bufdelete.nvim",
        config = function()
            -- Create an autocommand group for file change detection
            local auto_reload_group = vim.api.nvim_create_augroup("AutoReload", { clear = true })
            
            -- Enable autoread globally
            vim.o.autoread = true
            
            -- Create a timer for checking file changes
            local timer = vim.loop.new_timer()
            timer:start(0, 250, vim.schedule_wrap(function()
                -- Only check if Neovim is not in the middle of something
                if vim.fn.getcmdwintype() == "" then
                    -- Get current buffer number
                    local bufnr = vim.api.nvim_get_current_buf()
                    -- Get buffer's file path
                    local filepath = vim.api.nvim_buf_get_name(bufnr)
                    -- Only check if it's a real file
                    if filepath ~= "" and vim.fn.filereadable(filepath) == 1 then
                        vim.cmd('checktime ' .. bufnr)
                    end
                end
            end))

            -- Clean up timer when Neovim exits
            vim.api.nvim_create_autocmd("VimLeave", {
                group = auto_reload_group,
                callback = function()
                    timer:stop()
                    timer:close()
                end,
            })
        end
    },

    -- NeoTree
    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        dependencies = {
          "nvim-lua/plenary.nvim",
          "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
          "MunifTanjim/nui.nvim",
          -- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
        }
    },
}
