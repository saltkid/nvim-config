local utils = require 'utils'

vim.pack.add { utils.gh 'kdheepak/lazygit.nvim' }

-- config
vim.g.lazygit_floating_window_scaling_factor = 1.0

-- keymaps
utils.map('<leader>gg', '<cmd>LazyGit<cr>', { desc = 'Open LazyGit' })
