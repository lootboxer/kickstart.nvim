-- Neo-tree keymaps
vim.keymap.set('n', '<leader>e', function()
  if vim.bo.filetype == 'neo-tree' then
    -- We're in Neo-tree, go back to previous window
    vim.cmd 'wincmd p'
  else
    -- We're not in Neo-tree, reveal current file in Neo-tree
    vim.cmd 'Neotree reveal'
  end
end, { desc = 'Toggle between Neo-tree and buffer' })
vim.keymap.set('n', '<leader>E', '<cmd>Neotree focus<cr>', { desc = 'Focus Neo-tree' })
vim.keymap.set('n', '<leader>ge', '<cmd>Neotree git_status<cr>', { desc = 'Neo-tree Git Status' })
