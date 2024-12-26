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
    local width = vim.o.columns
    local height = math.floor(vim.o.lines * 0.3)
    local buf = vim.api.nvim_create_buf(false, true)
    
    vim.api.nvim_open_win(buf, true, {
        relative = 'editor',
        width = width,
        height = height,
        col = 0,
        row = vim.o.lines - height,
        style = 'minimal',
        border = 'rounded',
        title='Pop-up Terminal'
    })
    
    vim.cmd('term')
    vim.cmd('startinsert')
end, {})

-- setting keymap to open terminal with new command, Term
vim.keymap.set('n', '<leader>t', ':Term<CR>', { noremap = true })

-- setting keymap to open file explorer on left side
vim.keymap.set('n', '<leader>b', ':Neotree toggle<CR>', { noremap = true })
