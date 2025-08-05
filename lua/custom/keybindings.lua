-- Custom Keybinds.

vim.keymap.set('i', 'jk', '<Esc>', { desc = 'escape' })
vim.keymap.set('i', 'kj', '<Esc>', { desc = 'escape' })

vim.keymap.set('n', ',,', '<Cmd>ToggleTerm<CR>', { desc = 'Open terminal in horizontal split' })
vim.keymap.set('t', ',,', '<Cmd>ToggleTerm<CR>', { desc = 'Open terminal in horizontal split' })

vim.keymap.set('n', '<C-S-p>', '<cmd>Telescope commands<CR>', { desc = 'Command Palette' })

vim.keymap.set('n', '<C-q>', function()
  vim.cmd 'bdelete'
end)

-- Telescope
vim.keymap.set('n', '<leader>ff', '<cmd>Telescope find_files<cr>')
vim.keymap.set('n', '<leader>fg', '<cmd>Telescope live_grep<cr>')
vim.keymap.set('n', '<leader>fb', '<cmd>Telescope buffers<cr>')
vim.keymap.set('n', '<leader>fh', '<cmd>Telescope help_tags<cr>')
vim.keymap.set('n', '<leader>fr', '<cmd>Telescope oldfiles<cr>')

-- Neo-tree keymaps
vim.keymap.set('n', '<leader>e', '<cmd>Neotree toggle<cr>')
vim.keymap.set('n', '<leader>E', '<cmd>Neotree focus<cr>')
vim.keymap.set('n', '<leader>ge', '<cmd>Neotree git_status<cr>')

-- MiniBufremove
vim.keymap.set('n', '<leader>bd', function()
  require('mini.bufremove').delete(0) -- Delete current buffer
end, { desc = 'Delete buffer (mini.bufremove)' })

vim.keymap.set('n', '<leader>bD', function()
  require('mini.bufremove').delete(0, true) -- Force delete current buffer
end, { desc = 'Force delete buffer (mini.bufremove)' })

vim.keymap.set('n', '<leader>bw', function()
  require('mini.bufremove').wipeout(0) -- Wipeout current buffer
end, { desc = 'Wipeout buffer (mini.bufremove)' })

vim.keymap.set('n', '<leader>bW', function()
  require('mini.bufremove').wipeout(0, true) -- Force wipeout current buffer
end, { desc = 'Force wipeout buffer (mini.bufremove)' })

-- 4. Advanced usage - delete multiple buffers
vim.keymap.set('n', '<leader>ba', function()
  -- Delete all buffers except current
  local current = vim.api.nvim_get_current_buf()
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if buf ~= current and vim.bo[buf].buflisted then
      require('mini.bufremove').delete(buf)
    end
  end
end, { desc = 'Delete all other buffers' })

-- 5. Delete buffers by pattern
vim.keymap.set('n', '<leader>bp', function()
  vim.ui.input({ prompt = 'Delete buffers matching pattern: ' }, function(pattern)
    if pattern then
      for _, buf in ipairs(vim.api.nvim_list_bufs()) do
        local name = vim.api.nvim_buf_get_name(buf)
        if vim.bo[buf].buflisted and string.match(name, pattern) then
          require('mini.bufremove').delete(buf)
        end
      end
    end
  end)
end, { desc = 'Delete buffers by pattern' })

-- 6. Integration with buffer picker (like telescope)
vim.keymap.set('n', '<leader>bb', function()
  local buffers = {}
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if vim.api.nvim_buf_is_loaded(buf) and vim.bo[buf].buflisted then
      local name = vim.api.nvim_buf_get_name(buf)
      local display_name = name ~= '' and vim.fn.fnamemodify(name, ':t') or '[No Name]'
      table.insert(buffers, {
        id = buf,
        display = string.format('%d: %s', buf, display_name),
      })
    end
  end

  vim.ui.select(buffers, {
    prompt = 'Select buffer to delete:',
    format_item = function(item)
      return item.display
    end,
  }, function(choice)
    if choice then
      require('mini.bufremove').delete(choice.id)
    end
  end)
end, { desc = 'Select buffer to delete' })
--
-- Project management keybindings for neovim-project
local project_keys = {
  -- Project discovery and switching
  ['<leader>fp'] = { ':Telescope neovim-project discover<CR>', 'Find Projects' },
  ['<leader>pp'] = { ':Telescope neovim-project discover<CR>', 'Project Picker' },
  ['<leader>ph'] = { ':Telescope neovim-project history<CR>', 'Project History' },

  -- Quick actions
  ['<leader>pl'] = {
    function()
      require('neovim-project').last_project()
    end,
    'Last Project',
  },
  ['<leader>pr'] = { ':NeovimProjectRoot<CR>', 'Go to Project Root' },
}

for key, mapping in pairs(project_keys) do
  vim.keymap.set('n', key, mapping[1], { desc = mapping[2] })
end

-- Change buffer by number (example Alt+1, Alt+2...)
for i = 1, 9 do
  vim.keymap.set('n', '<M-' .. i .. '>', '<Cmd>BufferLineGoToBuffer ' .. i .. '<CR>')
end
