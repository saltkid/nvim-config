local utils = require 'utils'

-- build
vim.api.nvim_create_autocmd('PackChanged', {
  callback = function(ev)
    local name = ev.data.spec.name
    local kind = ev.data.kind
    if kind ~= 'install' and kind ~= 'update' then
      return
    end
    if name == 'markdown-preview.nvim' then
      if not ev.data.active then
        vim.cmd.packadd(name)
      end
      vim.fn['mkdp#util#install']()
      return
    end
  end,
})

vim.pack.add { utils.gh 'iamcco/markdown-preview.nvim' }

-- config
vim.g.mkdp_auto_close = 1
