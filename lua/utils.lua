---@class ConfigUtils
local M = {}

-- attaches the github domain to the given parameter.
-- e.g. utils.gh('user/repo') returns 'https://github.com/user/repo'
-- by reference.
-- used for tables containing atomic types
---@param repo string
---@return string link full repository link
function M.gh(repo)
  return 'https://github.com/' .. repo
end

-- adds a keymap
-- e.g.
-- - map('<leader>sf', function() end, { desc = 'test' })
-- - map('<leader>st', builtin.functioncall, { desc = 'test' }, {'n', 'v'})
-- equivalent:
-- - vim.keymap.set('n', '<leader>sf', function() end, { desc = 'test' })
-- - vim.keymap.set({'n', 'v'}, '<leader>st', builtin.functioncall, { desc = 'test' })
---@param l any keys
---@param r any action
---@param opts table usually for { desc = "" }, sometimes with buffer
---@param mode? 'n'|'i'|'v'|'x'|table either a single mode or multiple modes in a table.
---default value is 'n'
function M.map(l, r, opts, mode)
  mode = mode or 'n'
  opts = opts or {}
  vim.keymap.set(mode, l, r, opts)
end

---@param name string plugin name
---@param cmd table<string> command with args as a list
function M.run_build(name, cmd, cwd)
  local result = vim.system(cmd, { cwd = cwd }):wait()
  if result.code ~= 0 then
    local stderr = result.stderr or ''
    local stdout = result.stdout or ''
    local output = stderr ~= '' and stderr or stdout
    if output '' then
      output = 'No output form build command.'
    end
    vim.notify(('Build failed for %s:\n%s'):format(name, output), vim.log.levels.ERROR)
  end
end

--[[
Requires all `.lua` files in the given `path` (except `init.lua`). If a
directory contains `init.lua`, require that directory as a module.

This function should be used in `init.lua` to require everything else in the
directory.

Example:
```
plugins/
|__ init.lua
|__ foo.lua
|__ bar/
    |__ init.lua
    |__ baz.lua
```
If you call this function in init.lua:
  ```lua
  require_all_in("plugins", "plugins.")
  ```
the results would be:
  ```lua
  require("plugins.foo")
  require("plugins.bar")
  ```
If you call this function in bar/init.lua:
  ```lua
  require_all_in("plugins/bar", "plugins.bar.")
  ```
the results would be:
  ```lua
  require("plugins.baz")
  ```
--]]
---@param path string directory to scan. must be full path.
---@param module_prefix string lua module prefix, e.g. "plugins.", "plugins.bar"
function M.require_all_in(path, module_prefix)
  for name, ftype in vim.fs.dir(path) do
    local full_path = vim.fs.joinpath(path, name)
    if ftype == 'file' then
      if name:match '%.lua$' and name ~= 'init.lua' then
        local module = name:gsub('%.lua$', '')
        require(module_prefix .. module)
      end
    elseif ftype == 'directory' then
      local init_file = vim.fs.joinpath(full_path, 'init.lua')
      if vim.uv.fs_stat(init_file) then
        require(module_prefix .. name)
      end
    end
  end
end

return M
