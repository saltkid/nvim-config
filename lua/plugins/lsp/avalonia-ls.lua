-- NOTE: kept here since its the only one using this for now
vim.filetype.add {
  extension = {
    xaml = 'xml',
    axaml = 'xml',
  },
}
local avalonia_ls_group = vim.api.nvim_create_augroup('AvaloniaLS', { clear = true })
local function get_project_root(buf)
  local file_dir = vim.fs.dirname(vim.api.nvim_buf_get_name(buf))
  local project_file = vim.fs.find(function(name)
    return name:match '%.csproj$' or name:match '%.fsproj$'
  end, {
    upward = true,
    path = file_dir,
  })[1] -- get first root if with submodules
  if not project_file then
    return nil
  end
  return vim.fs.dirname(project_file)
end
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'xml',
  group = avalonia_ls_group,
  callback = function(event)
    local name = vim.api.nvim_buf_get_name(event.buf)
    if not name:match '%.axaml$' or name:match '%.xaml$' then
      return
    end
    local root = get_project_root(event.buf)
    if not root then
      return
    end
    vim.lsp.start {
      name = 'avalonia',
      cmd = { 'avalonia-ls' }, -- from https://github.com/SaverinOnRails/ls-for-avalonia
      root_dir = vim.fn.getcwd(),
    }
  end,
})
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'xml',
  group = avalonia_ls_group,
  callback = function(event)
    local name = vim.api.nvim_buf_get_name(event.buf)
    if not name:match '%.axaml$' or name:match '%.xaml$' then
      return
    end
    local root = get_project_root(event.buf)
    if not root then
      return
    end
    vim.lsp.start {
      name = 'avalonia',
      cmd = { 'avalonia-ls' }, -- from https://github.com/SaverinOnRails/ls-for-avalonia
      root_dir = vim.fn.getcwd(),
    }
  end,
})
