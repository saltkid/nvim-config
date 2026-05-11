-- Based on kickstart, thanks to all the contributors, really.

-- Enable faster startup by caching compiled Lua modules
vim.loader.enable()
-- NOTE: need to do this before plugins are loaded
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

require 'options'
require 'keymaps'
require 'plugins'
