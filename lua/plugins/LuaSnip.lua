local utils = require 'utils'

vim.pack.add { utils.gh 'L3MON4D3/LuaSnip' }
require('luasnip').setup {}

-- build
vim.api.nvim_create_autocmd('PackChanged', {
  callback = function(ev)
    local name = ev.data.spec.name
    local kind = ev.data.kind
    if kind ~= 'install' then
      return
    end
    if name == 'LuaSnip' then
      if vim.fn.has 'win32' ~= 1 and vim.fn.executable 'make' == 1 then
        utils.run_build(name, { 'make', 'install_jsregexp' }, ev.data.path)
      end
      return
    end
  end,
})
