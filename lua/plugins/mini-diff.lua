local utils = require 'utils'

vim.pack.add { utils.gh 'nvim-mini/mini.diff' }
require('mini.diff').setup {}

-- keymaps
vim.keymap.set('n', '<leader>gd', MiniDiff.toggle_overlay, { desc = '[S]earch [T]odos' })
