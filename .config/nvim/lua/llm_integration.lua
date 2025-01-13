local M = {}

function M.run_llm_session(mode)
  -- Get the full path of the current buffer
  local filepath = vim.api.nvim_buf_get_name(0)
  local current_bufnr = vim.api.nvim_get_current_buf()

  -- Check if the current buffer has a filename
  if filepath == "" then
    vim.notify("No file detected in the current buffer.", vim.log.levels.ERROR)
    return
  end
  
  -- Extract the file extension and name
  local filename = vim.fn.fnamemodify(filepath, ":t")
  local extension = vim.fn.fnamemodify(filepath, ":e")

  -- Extract session name by removing the .md extension
  local session_name = vim.fn.fnamemodify(filename, ":r")
  if session_name == "" then
    vim.notify("Session name could not be determined from the filename.", vim.log.levels.ERROR)
    return
  end
  
    -- Make the current buffer readonly
    vim.api.nvim_buf_set_option(current_bufnr, 'modifiable', false)
    vim.api.nvim_buf_set_option(current_bufnr, 'readonly', true)
  
  -- Construct the command using full path
  local cmd
  if mode == "session" then
    cmd = string.format("python ~/cli_llm/cli.py run-session %s", vim.fn.shellescape(session_name))
  else
    cmd = string.format("python ~/cli_llm/cli.py run-file %s", vim.fn.shellescape(filepath))
  end
  
  -- Variables to collect output
  local stderr_data = {}
  local has_error = false

  -- Use vim.loop to run the command asynchronously
  local stdout = vim.loop.new_pipe(false)
  local stderr = vim.loop.new_pipe(false)
  local handle
  
  handle = vim.loop.spawn("sh", {
    args = {"-c", cmd},
    stdio = {nil, stdout, stderr}
  }, function(code, signal)
    -- Close the pipes
    stdout:close()
    stderr:close()
    
    vim.schedule(function()
      -- Make the buffer modifiable again
      vim.api.nvim_buf_set_option(current_bufnr, 'modifiable', true)
      vim.api.nvim_buf_set_option(current_bufnr, 'readonly', false)

      if code ~= 0 then
        vim.notify(string.format("llm run-session failed with code %d", code), vim.log.levels.ERROR)
      else
        vim.notify(string.format("Session '%s' executed successfully.", session_name), vim.log.levels.INFO)
      end
    end)
    
    vim.loop.close(handle)
  end)
  
    -- Handle stdout (just for logging)
    stdout:read_start(function(err, data)
    assert(not err, err)
    if data then
      vim.schedule(function()
        vim.notify(data, vim.log.levels.INFO)
      end)
    end
  end)
end

return M

