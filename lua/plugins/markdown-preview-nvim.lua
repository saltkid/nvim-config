local utils = require 'utils'

vim.pack.add { utils.gh 'iamcco/markdown-preview.nvim' }

-- build
vim.api.nvim_create_autocmd('PackChanged', {
  callback = function(ev)
    local name = ev.data.spec.name
    if ev.data.kind ~= 'install' then
      return
    end
    if name == 'LuaSnip' then
      if vim.fn.executable 'npm' == 1 then
        vim.fn['mkdp#util#install']()
      end
      return
    end
  end,
})

-- config
vim.g.mkdp_auto_close = 1
