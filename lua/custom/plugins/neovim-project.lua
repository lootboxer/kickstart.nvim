local config = require 'custom.envs.neovim-project'

return {
  'coffebar/neovim-project',
  opts = {
    projects = config.projects or {},
    picker = {
      type = 'telescope', -- one of "telescope", "fzf-lua", or "snacks"
    },
    -- Last project configuration
    last_session_on_startup = true, -- automatically load last project on startup
    -- Dashboard integration (if you use dashboard)
    dashboard_mode = true,
  },
  init = function()
    -- enable saving the state of plugins in the session
    vim.opt.sessionoptions:append 'globals' -- save global variables that start with an uppercase letter and contain at least one lowercase letter.
  end,
  dependencies = {
    { 'nvim-lua/plenary.nvim' },
    -- optional picker
    { 'nvim-telescope/telescope.nvim', tag = '0.1.4' },
    -- optional picker
    { 'ibhagwan/fzf-lua' },
    -- optional picker
    -- { 'folke/snacks.nvim' },
    { 'Shatur/neovim-session-manager' },
  },
  lazy = false,
  priority = 100,
}
