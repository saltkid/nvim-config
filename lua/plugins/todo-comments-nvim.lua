local utils = require 'utils'

vim.pack.add { utils.gh 'folke/todo-comments.nvim' }
require('todo-comments').setup {
  -- keywords recognized as todo comments
  keywords = {
    TODO = { icon = ' ', color = 'info', alt = { 'NotImplementedError', 'todo' } },
  },
  highlight = {
    keyword = 'bg', -- "fg", "bg", "wide", "wide_bg", "wide_fg" or empty. (wide and wide_bg is the same as bg, but will also highlight surrounding characters, wide_fg acts accordingly but with fg)
    after = '', -- "fg" or "bg" or empty
    -- pattern = [[.*<(KEYWORDS)\s*:]], -- original pattern with colon
    pattern = [[.*<(KEYWORDS)\s*]], -- match without the extra colon. You'll likely get false positives,
    comments_only = false, -- uses treesitter to match keywords in comments only
  },
  search = {
    -- regex that will be used to match keywords.
    -- don't replace the (KEYWORDS) placeholder
    -- pattern = [[\b(KEYWORDS):]], -- original pattern with colon
    pattern = [[\b(KEYWORDS)\b]], -- match without the extra colon. You'll likely get false positives
  },
}

-- keymaps
utils.map('<leader>st', '<cmd>TodoFzfLua keywords=TODO,FIX<cr>', { desc = '[S]earch [T]odos' })
