return {
    -- Color scheme
    {
        "catppuccin/nvim",
        name = "catppuccin",
        priority = 1000,
        config = function()
            require("catppuccin").setup({
                flavour = "mocha", -- default
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
            -- Set the default colorscheme *before* defining autocommands
            vim.cmd.colorscheme "catppuccin"

            -- Autocommand for Markdown files
            vim.api.nvim_create_autocmd("BufEnter", {
                pattern="*",
                callback = function()
                    if vim.bo.filetype == "markdown" then
                        vim.cmd("colorscheme catppuccin-latte")
                        -- Override highlight groups for a minimalist white look
                        vim.api.nvim_set_hl(0, "Normal", { bg = "#FFFFFF", fg = "#333333" }) -- White background, dark grey text
                        vim.api.nvim_set_hl(0, "Comment", { fg = "#888888", italic = false }) -- Light grey comments, no italic
                        vim.api.nvim_set_hl(0, "markdownH1", { fg = "#000000", bold = true }) -- Black, bold headers
                        vim.api.nvim_set_hl(0, "markdownH2", { fg = "#000000", bold = true })
                        vim.api.nvim_set_hl(0, "markdownH3", { fg = "#000000", bold = true })
                        vim.api.nvim_set_hl(0, "markdownH4", { fg = "#000000", bold = true })
                        vim.api.nvim_set_hl(0, "markdownH5", { fg = "#000000", bold = true })
                        vim.api.nvim_set_hl(0, "markdownH6", { fg = "#000000", bold = true })
                        vim.api.nvim_set_hl(0, "markdownCode", { bg = "#F0F0F0", fg = "#333333" }) -- Light grey background for inline code
                        vim.api.nvim_set_hl(0, "markdownCodeBlock", { bg = "#F0F0F0", fg = "#333333" }) -- Light grey background for code blocks
                        vim.api.nvim_set_hl(0, "markdownLinkText", { fg = "#0077CC", underline = true }) -- Blue links, underlined
                        vim.api.nvim_set_hl(0, "markdownURL", { fg = "#0077CC", underline = true }) -- Blue URLs, underlined
                        vim.api.nvim_set_hl(0, "markdownListMarker", { fg = "#555555" }) -- Darker list markers
                        vim.api.nvim_set_hl(0, "ColorColumn", { bg = "#FFFFFF" }) -- White background for ColorColumn
                    else
                        vim.cmd("colorscheme catppuccin-mocha")
                    end
                end,
            })
        end,
    },

    -- Telescope for file navigation and searching
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
                        -- LaTeX auxiliary files
                        "%.aux",
                        "%.bcf",
                        "%.lof",
                        "%.log",
                        "%.xml",
                        "%.nav",
                        "%.snm",
                        "%.toc",
                    }
                },
                pickers = {
                    find_files = {
                        previewer = true,
                    },
                    live_grep = {
                        previewer = true,
                    }
                }
            })
        end
    },

    -- Treesitter for syntax highlighting and code parsing
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

    -- Harpoon for quick file navigation and bookmarking
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

    -- Undotree
    { "mbbill/undotree" },

    -- Git integration
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

            -- Configure mason to automatically install LSP servers
            require('mason').setup({})
            require('mason-lspconfig').setup(
                {
                    ensure_installed = {
                        'pyright',    -- Python LSP
                        'lua_ls',     -- Lua LSP
                        'sqlls',      -- SQL LSP
                        'emmet_ls',   -- HTML/CSS/Jinja LSP
                        'ts_ls',   -- TypeScript/JavaScript server
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
                        ["pyright"] = function()
                            require('lspconfig').pyright.setup({
                                settings = {
                                    python = {
                                        analysis = {
                                            autoSearchPaths = true,
                                            diagnosticMode = "workspace",
                                            useLibraryCodeForTypes = true,
                                            typeCheckingMode = "basic",
                                        },
                                    },
                                },
                            })
                        end,
                    }}
            )

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

            -- Add keybindings for LSP functionality
            lsp.on_attach(function(client, bufnr)
                local opts = {buffer = bufnr, remap = false}
                
                -- Go to definition
                vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
                -- Go to declaration
                vim.keymap.set("n", "gD", function() vim.lsp.buf.declaration() end, opts)
                -- Show implementation
                vim.keymap.set("n", "gi", function() vim.lsp.buf.implementation() end, opts)
                -- Show references
                vim.keymap.set("n", "gr", function() vim.lsp.buf.references() end, opts)
                -- Hover documentation
                vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
                -- Rename symbol
                vim.keymap.set("n", "<leader>rn", function() vim.lsp.buf.rename() end, opts)
                -- Code action
                vim.keymap.set("n", "<leader>ca", function() vim.lsp.buf.code_action() end, opts)
                -- Format code
                vim.keymap.set("n", "<leader>f", function() vim.lsp.buf.format() end, opts)
                
                -- Diagnostic navigation
                vim.keymap.set("n", "[d", function() vim.diagnostic.goto_prev() end, opts)
                vim.keymap.set("n", "]d", function() vim.diagnostic.goto_next() end, opts)
                vim.keymap.set("n", "<leader>d", function() vim.diagnostic.open_float() end, opts)
            end)

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

    -- Surround text objects like parentheses, quotes, etc.
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
                dir = "~/Google Drive/My Drive/Obsidian",
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
                    date_format = "%Y-%m-%d",
                    template="daily.md"
                },
                completion = {
                    nvim_cmp = true,
                    min_chars = 2,
                },
                templates = {
                    folder = "Templates",
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

            -- Function to open a specific Obsidian file
            local function open_obsidian_file(file_path)
                -- Construct the full path (assuming your vault path)
                local full_path = "~/Google Drive/My Drive/Obsidian/" .. file_path
                -- Expand the path and open the file
                vim.cmd('edit ' .. vim.fn.expand(full_path))
            end

            vim.keymap.set("n", "<leader>fo", function()
                open_obsidian_file("to-do.md")
            end)
            end
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
                condition = function()
                    local fn = vim.fn.expand("%:t")
                    local fp = vim.fn.expand("%:p")
                    local utils = require("auto-save.utils.data")
                    
                    -- Skip auto-saving Neovim config files
                    if fp:match("%.config/nvim") then
                        return false
                    end
                    
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

    -- NeoTree
    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        dependencies = {
          "nvim-lua/plenary.nvim",
          "nvim-tree/nvim-web-devicons",
          "MunifTanjim/nui.nvim",
        },
        config = function()
            require("neo-tree").setup({
                close_if_last_window = true,
                enable_git_status = true,
                enable_diagnostics = true,
                window = {
                    width = 30,
                    auto_open = false,
                    mappings = {
                        ["<space>"] = "none",
                    }
                },
                event_handlers = {
                  {
                    event = "file_open_requested",
                    handler = function()
                      require("neo-tree.command").execute({ action = "close" })
                    end
                  },
                },
                filesystem = {
                    watch_for_updates = true,
                    follow_current_file = {
                        enabled = true
                    },
                    filtered_items = {
                        visible = false,
                        hide_dotfiles = false,
                        hide_gitignored = false,
                        hide_by_name = {
                            -- LaTeX auxiliary files
                            ".aux",
                            ".bcf",
                            ".lof",
                            ".log",
                            ".xml",
                            ".nav",
                            ".snm",
                            ".toc",
                        },
                        never_show = {
                            ".DS_Store",
                        },
                    },
                },
            })
        end
    }
}
