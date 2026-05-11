local utils = require 'utils'

vim.pack.add { utils.gh 'NMAC427/guess-indent.nvim' }
require('guess-indent').setup {}
