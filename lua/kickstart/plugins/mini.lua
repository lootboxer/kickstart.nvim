return { -- Collection of various small independent plugins/modules
  'echasnovski/mini.nvim',
  config = function()
    require('mini.ai').setup()
    require('mini.surround').setup()
    require('mini.starter').setup()
    require('mini.bufremove').setup()
    require('mini.statusline').setup { use_icons = vim.g.have_nerd_font }
  end,
}
