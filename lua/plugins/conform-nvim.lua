local utils = require 'utils'

vim.pack.add { utils.gh 'stevearc/conform.nvim' }
require('conform').setup {
  notify_on_error = false,
  format_on_save = function(bufnr)
    local disabled_filetypes = {
      c = true,
      cpp = true,
    }
    if disabled_filetypes[vim.bo[bufnr].filetype] then
      return nil
    else
      return { timeout_ms = 500 }
    end
  end,
  default_format_opts = {
    lsp_format = 'fallback', -- Use external formatters if configured below, otherwise use LSP formatting. Set to `false` to disable LSP formatting entirely.
  },
  -- You can also specify external formatters in here.
  formatters_by_ft = {
    lua = { 'stylua' },
    python = { 'ruff_organize_imports', 'ruff_fix', 'ruff_format' },
    json = { 'jq' },
  },
}
utils.map('<leader>f', function()
  require('conform').format { async = true }
end, { desc = '[F]ormat buffer' }, { 'n', 'v' })
