local utils = require 'utils'

vim.pack.add { utils.gh 'ibhagwan/fzf-lua' }
require('fzf-lua').setup {
  keymap = {
    builtin = {
      ['<C-d>'] = 'preview-page-down',
      ['<C-u>'] = 'preview-page-up',
    },
  },
}

-- keymaps
utils.map('<leader>sk', FzfLua.keymaps, { desc = '[S]earch [K]eymaps' })
utils.map('<leader>sf', FzfLua.files, { desc = '[S]earch [F]iles' })
utils.map('<leader>sw', FzfLua.grep_cword, { desc = '[S]earch current [W]ord' })
utils.map('<leader>sw', FzfLua.grep_visual, { desc = '[S]earch current [W]ord' }, 'v')
utils.map('<leader>sg', function()
  FzfLua.grep { resume = true }
end, { desc = '[S]earch by [G]rep' })
utils.map('<leader>sd', FzfLua.diagnostics_workspace, { desc = '[S]earch [D]iagnostics' })
utils.map('<leader>sr', FzfLua.resume, { desc = '[S]earch [R]esume' })
utils.map('<leader>s.', FzfLua.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
utils.map('<leader>sc', FzfLua.commands, { desc = '[S]earch [C]ommands' })
utils.map('<leader><leader>', FzfLua.buffers, { desc = '[ ] Find existing buffers' })
utils.map('<leader>/', FzfLua.lgrep_curbuf, { desc = '[/] Fuzzily search in current buffer' })
utils.map('<leader>sn', function()
  FzfLua.files { cwd = vim.fn.stdpath 'config' }
end, { desc = '[S]earch [N]eovim files' })

-- keymaps on files with lsp
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('fzf-lua-lsp-attach', { clear = true }),
  callback = function(event)
    local buf = event.buf
    -- Find references for the word under your cursor.
    utils.map('grr', FzfLua.lsp_references, { buffer = buf, desc = '[G]oto [R]eferences' })

    -- Jump to the implementation of the word under your cursor.
    -- Useful when your language has ways of declaring types without an actual implementation.
    utils.map('gri', FzfLua.lsp_implementations, { buffer = buf, desc = '[G]oto [I]mplementation' })

    -- Jump to the definition of the word under your cursor.
    -- This is where a variable was first declared, or where a function is defined, etc.
    -- To jump back, press <C-t>.
    utils.map('grd', FzfLua.lsp_definitions, { buffer = buf, desc = '[G]oto [D]efinition' })

    -- Fuzzy find all the symbols in your current document.
    -- Symbols are things like variables, functions, types, etc.
    utils.map('gO', FzfLua.lsp_document_symbols, { buffer = buf, desc = 'Open Document Symbols' })

    -- Fuzzy find all the symbols in your current workspace.
    -- Similar to document symbols, except searches over your entire project.
    utils.map('gW', FzfLua.lsp_workspace_symbols, { buffer = buf, desc = 'Open Workspace Symbols' })

    -- Jump to the type of the word under your cursor.
    -- Useful when you're not sure what type a variable is and you want to see
    -- the definition of its *type*, not where it was *defined*.
    utils.map('grt', FzfLua.lsp_typedefs, { buffer = buf, desc = '[G]oto [T]ype Definition' })
  end,
})
