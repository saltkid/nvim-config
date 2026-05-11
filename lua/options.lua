-- OPTIONS {{{
vim.o.number = true
vim.o.cursorlineopt = 'number'
vim.o.relativenumber = true

vim.o.mouse = 'a'

vim.o.showmode = false
vim.g.have_nerd_font = true
vim.o.signcolumn = 'yes'
vim.o.breakindent = true
vim.o.wrap = false
vim.o.scrolloff = 10

vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true

vim.o.incsearch = true
vim.o.inccommand = 'split'
vim.o.splitright = true
vim.o.splitbelow = true

vim.o.foldenable = true
vim.o.foldlevel = 0
vim.o.foldlevelstart = 0
vim.o.foldmethod = 'marker'

-- sync clipboard between OS and neovim
-- scheduling setting after `UiEnter` because it can increase startup-time
vim.schedule(function()
  vim.o.clipboard = 'unnamedplus'
end)

vim.o.undofile = true

vim.o.ignorecase = true
vim.o.smartcase = true

vim.o.updatetime = 250
vim.o.timeoutlen = 300

vim.o.list = true
vim.opt.listchars = {
  tab = '» ',
  eol = '¬',
  space = '·',
  trail = '·',
  nbsp = '␣',
}

vim.o.confirm = true
-- }}}

-- AUTOCOMMANDS {{{
local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

autocmd('TextYankPost', {
  desc = 'Highlight on yank',
  group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})

-- persistent folds between sessions
-- credits: https://github.com/LazyVim/LazyVim/discussions/1358
-- - thank you [Steve Dondley](https://github.com/sdondley)
autocmd('BufWinLeave', {
  pattern = '*.*',
  callback = function()
    vim.cmd.mkview()
  end,
})
autocmd('BufWinEnter', {
  group = augroup('Persistent Folds', { clear = true }),
  pattern = '*.*',
  callback = function()
    vim.cmd.loadview { mods = { emsg_silent = true } }
  end,
})
-- }}}
