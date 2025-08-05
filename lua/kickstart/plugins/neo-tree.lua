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
    close_if_last_window = false,
    popup_border_style = 'rounded',
    enable_git_status = true,
    enable_diagnostics = true,
    window = {
      position = 'left',
      width = 36,
      mapping_options = {
        noremap = true,
        nowait = true,
      },
    },
    filesystem = {
      visible = false,
      hide_dotfiles = false,
      hide_gitignored = true,
      hide_hidden = true,
      filesystem = {
        follow_current_file = {
          enabled = true,
          leave_dirs_open = false,
        },
      },
      filtered_items = {
        hide_dotfiles = false,
        hide_gitignored = false,
        hide_by_name = {
          'node_modules',
        },
        never_show = {
          '.DS_Store',
          'thumbs.db',
        },
      },
      -- avante
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
    default_component_configs = {
      indent = {
        with_markers = true,
        indent_marker = '│',
        last_indent_marker = '└',
        highlight = 'NeoTreeIndentMarker',
      },
      icon = {
        folder_closed = '📁',
        folder_open = '📂',
        folder_empty = '(empty)',
        default = '*',
        highlight = 'NeoTreeFileIcon',
      },
      modified = {
        symbol = '[+]',
        highlight = 'NeoTreeModified',
      },
      name = {
        trailing_slash = false,
        use_git_status_colors = true,
        highlight = 'NeoTreeFileName',
      },
      git_status = {
        symbols = {
          added = '✚',
          modified = 'm',
          deleted = '✖',
          renamed = 'r',
          untracked = '(untracked)',
          ignored = 'i',
          unstaged = '(unstaged)',
          staged = '(staged)',
          conflict = '(conflict)',
        },
      },
    },
  },
  config = function(_, opts)
    require('neo-tree').setup(opts)
    vim.api.nvim_create_autocmd('VimEnter', {
      callback = function()
        local arg = vim.fn.argv(0) -- the first argument during execution neovim
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
