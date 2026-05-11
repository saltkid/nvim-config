local utils = require 'utils'

vim.pack.add { utils.gh 'NStefan002/screenkey.nvim' }
require('screenkey').setup {}

-- keymaps
utils.map('<leader>ss', '<cmd>Screenkey<cr>', { desc = 'Toggle [S]creen[K]ey' })
