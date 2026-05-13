local utils = require 'utils'

vim.pack.add { utils.gh 'saghen/blink.cmp' }
require('blink.cmp').setup {
  keymap = {
    preset = 'default',
  },
  appearance = { nerd_font_variant = 'mono' },
  completion = { documentation = {
    auto_show = false,
    auto_show_delay_ms = 500,
  } },
  sources = {
    default = { 'lsp', 'path', 'snippets', 'easy-dotnet' },
    providers = {
      ['easy-dotnet'] = {
        name = 'easy-dotnet',
        enabled = true,
        module = 'easy-dotnet.completion.blink',
        score_offset = 10000,
        async = true,
      },
    },
  },
  snippets = { preset = 'luasnip' },
  fuzzy = { implementation = 'prefer_rust_with_warning' },
  signature = { enabled = true },
}
