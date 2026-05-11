local utils = require 'utils'

vim.pack.add { utils.gh 'nvim-treesitter/nvim-treesitter-context' }
require('treesitter-context').setup {
  max_lines = 5,
}
