vim.keymap.set('n', '<leader>pp', ':Telescope neovim-project discover<CR>', { desc = 'Project Picker' })
vim.keymap.set('n', '<leader>ph', ':Telescope neovim-project history<CR>', { desc = 'Project History' })
vim.keymap.set('n', '<leader>pr', ':NeovimProjectLoad<CR>', { desc = 'Go to Project Root' })
