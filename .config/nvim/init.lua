vim.g.mapleader = " "
vim.g.maplocalleader = " "

require('custom.auto-session').setup()

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

-- Load core configurations
require("config.options")               -- Load options first
require("lazy").setup("config.plugins") -- Then load plugins
require("config.keymaps")               -- Load keymaps last


vim.opt.laststatus = 3

require('avante_lib').load()

require('custom.auto-session').setup()

require('avante').setup({
  provider = "claude",
  auto_suggestions_provider = "claude",
  claude = {
    endpoint = "https://api.anthropic.com",
    model = "claude-3-5-sonnet-20241022",
    temperature = 0,
    max_tokens = 4096,
  },
  behaviour = {
    auto_suggestions = false,
    auto_set_highlight_group = true,
    auto_set_keymaps = true,
    auto_apply_diff_after_generation = false,
  },
})

vim.api.nvim_create_user_command('Term', function()
    -- Create a new split at the bottom with 30% height
    vim.cmd('botright split')
    vim.cmd('resize ' .. math.floor(vim.o.lines * 0.3))
    
    -- Open terminal in the new split
    vim.cmd('term')
    vim.cmd('startinsert')
end, {})

vim.api.nvim_create_autocmd('TermOpen', {
    callback = function()
        -- Disable line numbers in terminal
        vim.opt_local.number = false
        vim.opt_local.relativenumber = false
        -- Enable mouse support for terminal
        vim.opt_local.mouse = 'a'
        -- Set different color scheme for terminal buffer only
        vim.opt_local.winhighlight = 'Normal:TermBackground'
        vim.api.nvim_set_hl(0, 'TermBackground', { bg = '#000000' })  -- Deep navy blue
        -- Start in insert mode
        vim.cmd('startinsert')
        -- Key mappings
        -- exiting termianl mode with regular escape key: "in terminal mode, <C-\><C-n> is equivalent to <Esc>"
        vim.keymap.set('t', 'vv', [[<C-\><C-n>]], {buffer = true})

        vim.keymap.set('n', 'i', 'i', {buffer = true})
        vim.keymap.set('n', 'a', 'a', {buffer = true})
        -- Enable clipboard integration
        vim.opt_local.clipboard = 'unnamedplus'
    end
})

-- setting keymap to open terminal with new command, Term
vim.keymap.set('n', '<leader>t', ':Term<CR>', { noremap = true })

-- setting keymap to open file explorer on left side
vim.keymap.set('n', '<leader>b', ':Neotree toggle<CR>', { noremap = true })

-- For session mode
vim.keymap.set('n', '<leader>ls', function() require('llm_integration').run_llm_session("session") end, { noremap = true, silent = false, desc = "Run LLM Session" })

-- For file mode
vim.keymap.set('n', '<leader>ll', function() require('llm_integration').run_llm_session("file") end, { noremap = true, silent = false, desc = "Run LLM File" })
