local utils = require 'utils'

vim.pack.add { utils.gh 'rebelot/kanagawa.nvim' }
require('kanagawa').setup { ---@diagnostic disable-line: missing-fields
  transparent = true,
  background = {
    dark = 'dragon',
    light = 'lotus',
  },
  colors = {
    pallete = {
      sumiInk0 = '#000000',
      fujiWhite = '#ffffff',
    },
    theme = {
      all = {
        ui = {
          bg_gutter = 'none',
        },
      },
    },
  },
  overrides = function(colors)
    local theme = colors.theme
    return {
      NormalFloat = { bg = theme.ui.bg_p1, fg = theme.ui.fg_dim },
      -- -- recommended for Telescope
      -- TelescopeTitle = { fg = theme.ui.special, bold = true },
      -- TelescopePromptNormal = { bg = theme.ui.bg_p1 },
      -- TelescopePromptBorder = { fg = theme.ui.bg_p1, bg = theme.ui.bg_p1 },
      -- TelescopeResultsNormal = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m1 },
      -- TelescopeResultsBorder = { fg = theme.ui.bg_m1, bg = theme.ui.bg_m1 },
      -- TelescopePreviewNormal = { bg = theme.ui.bg_dim },
      -- TelescopePreviewBorder = { bg = theme.ui.bg_dim, fg = theme.ui.bg_dim },
      -- recommended for pop up menus
      Pmenu = { fg = theme.ui.shade0, bg = theme.ui.bg_p1 }, -- add `blend = vim.o.pumblend` to enable transparency
      PmenuSel = { fg = 'NONE', bg = theme.ui.bg_p2 },
      PmenuSbar = { bg = theme.ui.bg_m1 },
      PmenuThumb = { bg = theme.ui.bg_p2 },
    }
  end,
}

-- config
vim.cmd.colorscheme 'kanagawa'
