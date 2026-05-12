# Plugins
Can be modularized (see [`lsp`](./lsp)). Each `init.lua` is
expected to call `require_all_in` to require every other lua in the directory.
For example, in [`plugins/lsp/init.lua`](./lsp/init.lua):
```lua
local utils = require 'utils'
utils.require_all_in(
    vim.fs.joinpath(vim.fn.stdpath 'config', 'lua', 'plugins', 'lsp'),
    'plugins.lsp.'
)
```
