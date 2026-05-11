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

return M
