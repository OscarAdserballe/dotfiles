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
