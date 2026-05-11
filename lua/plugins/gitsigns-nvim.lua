local utils = require 'utils'

vim.pack.add { utils.gh 'lewis6991/gitsigns.nvim' }

require('gitsigns').setup {
  signs = {
    add = { text = '+' }, ---@diagnostic disable-line: missing-fields
    change = { text = '~' }, ---@diagnostic disable-line: missing-fields
    delete = { text = '_' }, ---@diagnostic disable-line: missing-fields
    topdelete = { text = '‾' }, ---@diagnostic disable-line: missing-fields
    changedelete = { text = '~' }, ---@diagnostic disable-line: missing-fields
  },
  -- keymaps on attach
  on_attach = function(bufnr)
    local gitsigns = require 'gitsigns'

    -- Navigation
    utils.map(']c', function()
      if vim.wo.diff then
        vim.cmd.normal { ']c', bang = true }
      else
        gitsigns.nav_hunk 'next'
      end
    end, { desc = 'Jump to next git [c]hange' })

    utils.map('[c', function()
      if vim.wo.diff then
        vim.cmd.normal { '[c', bang = true }
      else
        gitsigns.nav_hunk 'prev'
      end
    end, { desc = 'Jump to previous git [c]hange' })

    -- Actions
    -- visual mode
    utils.map('<leader>hs', function()
      gitsigns.stage_hunk { vim.fn.line '.', vim.fn.line 'v' }
    end, { desc = 'git [s]tage hunk' }, 'v')
    utils.map('<leader>hr', function()
      gitsigns.reset_hunk { vim.fn.line '.', vim.fn.line 'v' }
    end, { desc = 'git [r]eset hunk' }, 'v')
    -- normal mode
    utils.map('<leader>hs', gitsigns.stage_hunk, { buffer = bufnr, desc = 'git [s]tage hunk' })
    utils.map('<leader>hr', gitsigns.reset_hunk, { buffer = bufnr, desc = 'git [r]eset hunk' })
    utils.map('<leader>hS', gitsigns.stage_buffer, { buffer = bufnr, desc = 'git [S]tage buffer' })
    utils.map('<leader>hR', gitsigns.reset_buffer, { buffer = bufnr, desc = 'git [R]eset buffer' })
    utils.map('<leader>hp', gitsigns.preview_hunk, { buffer = bufnr, desc = 'git [p]review hunk' })
    utils.map('<leader>hi', gitsigns.preview_hunk_inline, { buffer = bufnr, desc = 'git preview hunk [i]nline' })
    utils.map('<leader>hb', function()
      gitsigns.blame_line { full = true }
    end, { buffer = bufnr, desc = 'git [b]lame line' })
    utils.map('<leader>hd', gitsigns.diffthis, { buffer = bufnr, desc = 'git [d]iff against index' })
    utils.map('<leader>hD', function()
      gitsigns.diffthis '@'
    end, { buffer = bufnr, desc = 'git [D]iff against last commit' })
    utils.map('<leader>hQ', function()
      gitsigns.setqflist 'all'
    end, { buffer = bufnr, desc = 'git hunk [Q]uickfix list (all files in repo)' })
    utils.map('<leader>hq', gitsigns.setqflist, { buffer = bufnr, desc = 'git hunk [q]uickfix list (all changes in this file)' })
    -- Toggles
    utils.map('<leader>tb', gitsigns.toggle_current_line_blame, { buffer = bufnr, desc = '[T]oggle git show [b]lame line' })
    utils.map('<leader>tw', gitsigns.toggle_word_diff, { buffer = bufnr, desc = '[T]oggle git intra-line [w]ord diff' })

    -- Text object
    utils.map('ih', gitsigns.select_hunk, { buffer = bufnr }, { 'o', 'x' })
  end,
}
