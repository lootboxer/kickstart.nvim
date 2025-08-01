-- Custom Keybinds.

vim.keymap.set('i', 'jk', '<Esc>', { desc = 'escape' })
vim.keymap.set('i', 'kj', '<Esc>', { desc = 'escape' })

vim.keymap.set('n', ',,', '<Cmd>ToggleTerm<CR>', { desc = 'Open terminal in horizontal split' })
vim.keymap.set('t', ',,', '<Cmd>ToggleTerm<CR>', { desc = 'Open terminal in horizontal split' })

vim.keymap.set('n', '<C-q>', function()
  local current_ft = vim.bo.filetype

  -- Case 1: If we're in Neo-tree, just close it
  if current_ft == 'neo-tree' then
    vim.cmd 'quit'
    return
  end

  -- Case 2: Close the current buffer
  local current_buf = vim.api.nvim_get_current_buf()
  vim.cmd 'bdelete'

  -- Check remaining listed buffers
  local buffers = vim.fn.getbufinfo { buflisted = 1 }
  if #buffers > 0 then
    -- Open the next available buffer
    local next_buf = buffers[1].bufnr
    vim.api.nvim_set_current_buf(next_buf)
  else
    -- No other buffers left, close the window or tab
    if vim.fn.winnr '$' == 1 then
      vim.cmd 'quit' -- Close the entire tab if it's the only window
    else
      vim.cmd 'close' -- Close just this window
    end
  end

  -- Case 3: If Neo-tree is the only window left, close it
  if vim.fn.winnr '$' == 1 and vim.bo.filetype == 'neo-tree' then
    vim.cmd 'quit'
  end
end, { desc = 'Close buffer smartly', silent = true })

-- Change buffer by number (example Alt+1, Alt+2...)
for i = 1, 9 do
  vim.keymap.set('n', '<M-' .. i .. '>', '<Cmd>BufferLineGoToBuffer ' .. i .. '<CR>')
end
