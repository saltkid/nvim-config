local utils = require 'utils'

vim.pack.add { utils.gh 'nvim-mini/mini.surround' }
require('mini.surround').setup {}

-- keymaps
-- to restore default 's' behavior
vim.keymap.del({ 'n', 'x' }, 's')
