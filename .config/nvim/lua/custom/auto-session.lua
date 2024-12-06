local M = {}

function M.setup()
  -- Create session directory if it doesn't exist
  vim.fn.mkdir(vim.fn.stdpath('state') .. '/sessions', 'p')

  -- Auto save session before exiting
  vim.api.nvim_create_autocmd('VimLeave', {
    callback = function()
      local session_file = vim.fn.stdpath('state') .. '/sessions/tmux_' .. vim.fn.environ()['TMUX_PANE']:gsub('%%','_') .. '.vim'
      vim.cmd('mksession! ' .. session_file)
    end
  })
end

return M
