local utils = require 'utils'

-- dependencies
vim.pack.add { utils.gh 'nvim-lua/plenary.nvim', utils.gh 'folke/snacks.nvim' }
-- install
vim.pack.add { utils.gh 'GustavEikaas/easy-dotnet.nvim' }
require('easy-dotnet').setup()

vim.api.nvim_create_autocmd('PackChanged', {
  callback = function(ev)
    local name = ev.data.spec.name
    local kind = ev.data.kind
    if kind ~= 'install' and kind ~= 'update' then
      return
    end
    if name == 'easy-dotnet' then
      if not ev.data.active then
        vim.cmd.packadd(name)
      end
      vim.cmd 'Dotnet _server update'
      return
    end
  end,
})
