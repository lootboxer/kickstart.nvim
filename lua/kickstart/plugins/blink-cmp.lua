return { -- Autocompletion
  'saghen/blink.cmp',
  version = '1.*',
  event = 'VimEnter',
  dependencies = { 'L3MON4D3/LuaSnip', 'folke/lazydev.nvim' },
  opts = {
    keymap = {
      preset = 'super-tab',
      ['<CR>'] = { 'accept', 'fallback' },
    },
    sources = {
      default = { 'lazydev', 'lsp', 'path', 'snippets', 'buffer' },
      providers = {
        lazydev = {
          name = 'LazyDev',
          module = 'lazydev.integrations.blink',
          score_offset = 100,
        },
      },
    },
    completion = {
      ghost_text = {
        enabled = true,
      },
      documentation = {
        auto_show = true,
        auto_show_delay_ms = 500,
        treesitter_highlighting = true,
        window = {
          max_width = 80,
          max_height = 20,
          border = 'single',
          scrollbar = true,
        },
      },
      menu = {
        draw = {
          columns = {
            { 'kind_icon' },
            { 'label', 'label_description', gap = 1 },
            { 'source_name' },
          },
        },
      },
    },
    signature = {
      enabled = true,
      window = {
        max_width = 80,
        max_height = 10,
        border = 'single',
        scrollbar = true,
      },
    },
  },
}
