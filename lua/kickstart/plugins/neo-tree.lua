-- Neo-tree is a Neovim plugin to browse the file system
-- https://github.com/nvim-neo-tree/neo-tree.nvim

return {
  'nvim-neo-tree/neo-tree.nvim',
  version = '*',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
    'MunifTanjim/nui.nvim',
  },
  lazy = false,
  keys = {
    { '<leader>e', ':Neotree reveal<CR>', desc = 'NeoTree reveal', silent = true },
  },
  opts = {
    window = {
      position = 'left',
      width = 36,
      mappings = {
        ['<leader>e'] = 'close_window',
        ['<C-cr>'] = {
          'open',
          config = {
            open_command = 'tabnew',
          },
        },
        ['oa'] = 'avante_add_files',
      },
    },
    filesystem = {
      bind_to_cwd = true,
      commands = {
        avante_add_files = function(state)
          local node = state.tree:get_node()
          local filepath = node:get_id()
          local relative_path = require('avante.utils').relative_path(filepath)

          local sidebar = require('avante').get()

          local open = sidebar:is_open()
          -- ensure avante sidebar is open
          if not open then
            require('avante.api').ask()
            sidebar = require('avante').get()
          end

          sidebar.file_selector:add_selected_file(relative_path)

          -- remove neo tree buffer
          if not open then
            sidebar.file_selector:remove_selected_file 'neo-tree filesystem [1]'
          end
        end,
      },
    },
  },
  config = function(_, opts)
    require('neo-tree').setup(opts)
    vim.api.nvim_create_autocmd('VimEnter', {
      callback = function()
        local arg = vim.fn.argv(0) -- первый аргумент при запуске Neovim
        if arg ~= '' and vim.fn.isdirectory(arg) == 1 then
          vim.cmd('cd ' .. arg)
        end
      end,
    })

    vim.api.nvim_create_autocmd('VimEnter', {
      callback = function()
        local arg = vim.fn.argv(0)
        if arg ~= '' then
          if vim.fn.isdirectory(arg) == 1 then
            -- if directory
            vim.cmd('cd ' .. arg)
          elseif vim.fn.filereadable(arg) == 1 then
            -- if file
            local dir = vim.fn.fnamemodify(arg, ':p:h')
            vim.cmd('cd ' .. dir)
          end
        end
      end,
    })
  end,
}
