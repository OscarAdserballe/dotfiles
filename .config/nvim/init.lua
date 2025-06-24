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
    model = "claude-3-7-sonnet-latest",
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
end, {}) vim.api.nvim_create_autocmd('TermOpen', {
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

-- in terminal mode set <Esc> to <C-\><C-n>
vim.keymap.set('t', '<Esc>', '<C-\\><C-n>')


vim.keymap.set('n', '<leader>fb', ':enew | setlocal filetype=sql<CR>', { desc = '[F]ile [B]uffer (new SQL)', silent = true, nowait = true })

-- 2. Function and command to RUN a BigQuery query on the current buffer's content
local function BQRunQuery()
  -- Get all lines from the current buffer
  local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)

  -- Check if the buffer is empty
  if #lines == 0 or (#lines == 1 and #lines[1] == 0) then
    vim.notify("Buffer is empty, nothing to run.", vim.log.levels.WARN)
    return
  end

  -- Use vim.fn.systemlist to run the command and capture the output.
  -- The second argument passes the buffer content via stdin.
  vim.notify("Running BigQuery query...", vim.log.levels.INFO)
  local output = vim.fn.systemlist("bq query --use_legacy_sql=false", lines)

  -- Check for errors during command execution
  if vim.v.shell_error ~= 0 then
     vim.notify("BQ command failed. Is 'bq' in your PATH and are you authenticated?", vim.log.levels.ERROR)
     -- Prepend the error message to the output for context
     table.insert(output, 1, "Command failed with exit code: " .. vim.v.shell_error)
  end

  vim.cmd('new')

  -- Set buffer options for a clean "output" window
  vim.bo.buftype = 'nofile' -- Not a real file
  vim.bo.bufhidden = 'wipe' -- Close it without saving
  vim.bo.swapfile = false   -- No swap file
  vim.bo.readonly = true    -- Make it read-only
  vim.bo.filetype = 'text'  -- Set filetype for syntax highlighting
  vim.wo.wrap = false       -- Disable line wrapping to allow horizontal scrolling
  vim.wo.sidescrolloff = 5  -- Keep 5 columns visible when scrolling horizontally

  -- Insert the captured output into the new buffer
  vim.api.nvim_buf_set_lines(0, 0, -1, false, output)
  vim.notify("Query complete.", vim.log.levels.INFO)
end
-- Create the user command :BQRunQuery
vim.api.nvim_create_user_command('BQRunQuery', BQRunQuery, {
  bang = false,
  desc = "Perform a BigQuery query on the current buffer's SQL content"
})

-- Map the function to <leader>fq for quick execution
vim.keymap.set('n', '<leader>fq', ':BQRunQuery<CR>', { desc = '[F]ire BigQuery [Q]uery', silent = true, nowait = true })

