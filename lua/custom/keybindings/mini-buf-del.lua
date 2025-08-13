vim.keymap.set('n', '<leader>bd', function()
  require('mini.bufremove').delete(0) -- Delete current buffer
end, { desc = 'Delete buffer (mini.bufremove)' })

vim.keymap.set('n', '<leader>q', function()
  require('mini.bufremove').delete(0) -- Delete current buffer
end, { desc = 'Delete buffer (mini.bufremove)' })

vim.keymap.set('n', '<leader>bD', function()
  require('mini.bufremove').delete(0, true) -- Force delete current buffer
end, { desc = 'Force delete buffer (mini.bufremove)' })

vim.keymap.set('n', '<leader>ba', function()
  -- Delete all buffers except current
  local current = vim.api.nvim_get_current_buf()
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if buf ~= current and vim.bo[buf].buflisted then
      require('mini.bufremove').delete(buf)
    end
  end
end, { desc = 'Delete all other buffers' })
