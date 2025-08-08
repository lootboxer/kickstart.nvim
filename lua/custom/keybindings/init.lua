-- Custom Keybinds.
vim.keymap.set('i', 'jk', '<Esc>', { desc = 'escape' })
vim.keymap.set('i', 'kj', '<Esc>', { desc = 'escape' })

-- Change buffer by number (example Alt+1, Alt+2...)
for i = 1, 9 do
  vim.keymap.set('n', '<M-' .. i .. '>', '<Cmd>BufferLineGoToBuffer ' .. i .. '<CR>')
end

require 'custom.keybindings.mini-buf-del'
require 'custom.keybindings.neo-tree'
require 'custom.keybindings.neovim-project'
require 'custom.keybindings.telescope'
require 'custom.keybindings.toggleterm'
