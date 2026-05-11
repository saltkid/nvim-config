local utils = require 'utils'

vim.pack.add { utils.gh 'brenoprata10/nvim-highlight-colors' }
require('nvim-highlight-colors').setup {}

-- init
require('nvim-highlight-colors').turnOn()
