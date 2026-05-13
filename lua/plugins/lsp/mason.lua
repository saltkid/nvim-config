local utils = require 'utils'

-- SERVER CONFIGS {{{
---@type table<string, vim.lsp.Config>
local servers = {
  gopls = {},
  pyright = {},
  ruff = {},
  -- rust_analyzer = {},
  lua_ls = {
    on_init = function(client)
      client.server_capabilities.documentFormattingProvider = false -- Disable formatting (formatting is done by stylua)

      if client.workspace_folders then
        local path = client.workspace_folders[1].name
        if path ~= vim.fn.stdpath 'config' and (vim.uv.fs_stat(path .. '/.luarc.json') or vim.uv.fs_stat(path .. '/.luarc.jsonc')) then
          return
        end
      end

      client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
        runtime = {
          version = 'LuaJIT',
          path = { 'lua/?.lua', 'lua/?/init.lua' },
        },
        workspace = {
          checkThirdParty = false,
          -- NOTE: this is a lot slower and will cause issues when working on your own configuration.
          --  See https://github.com/neovim/nvim-lspconfig/issues/3189
          library = vim.tbl_extend('force', vim.api.nvim_get_runtime_file('', true), {
            '${3rd}/luv/library',
            '${3rd}/busted/library',
          }),
        },
      })
    end,
    ---@type lspconfig.settings.lua_ls
    settings = {
      Lua = {
        format = { enable = false }, -- Disable formatting (formatting is done by stylua)
      },
    },
  },
}
local formatters = {
  csharpier = {},
  jq = {},
}
-- }}}

-- MASON {{{
vim.pack.add {
  utils.gh 'neovim/nvim-lspconfig',
  utils.gh 'mason-org/mason.nvim',
  utils.gh 'mason-org/mason-lspconfig.nvim',
  utils.gh 'WhoIsSethDaniel/mason-tool-installer.nvim',
}
require('mason').setup {
  registries = {
    'github:mason-org/mason-registry',
    'github:Crashdummyy/mason-registry',
  },
}
local ensure_installed = vim.tbl_keys(servers or {})
vim.list_extend(ensure_installed, vim.tbl_keys(formatters or {}))
vim.list_extend(ensure_installed, {
  -- You can add other tools here that you want Mason to install
  'roslyn', -- added here since registries above need to be registered first
})

require('mason-tool-installer').setup { ensure_installed = ensure_installed }

for name, server in pairs(servers) do
  vim.lsp.config(name, server)
  vim.lsp.enable(name)
end
-- }}}
