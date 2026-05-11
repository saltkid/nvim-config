local utils = require 'utils'

vim.pack.add { utils.gh 'stevearc/oil.nvim' }
require('oil').setup {
  delete_to_trash = true,
}

utils.map('<leader>oi', '<cmd>Oil<cr>', { desc = '[oi]l.nvim' })
