local utils = require 'utils'
utils.require_all_in(vim.fs.joinpath(vim.fn.stdpath 'config', 'lua', 'plugins', 'lsp'), 'plugins.lsp.')
