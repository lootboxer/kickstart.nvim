-- Project management keybindings for neovim-project
--
vim.keymap.set('n', '<leader>pp', ':Telescope neovim-project discover<CR>', { desc = 'Project Picker' })
vim.keymap.set('n', '<leader>ph', ':Telescope neovim-project history<CR>', { desc = 'Project History' })
vim.keymap.set('n', '<leader>pl', function()
  require('neovim-project').last_project()
end, { desc = 'Last Project' })
vim.keymap.set('n', '<leader>pr', ':NeovimProjectRoot<CR>', { desc = 'Go to Project Root' })
