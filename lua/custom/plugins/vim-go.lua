-- Go development
return {
  'fatih/vim-go',
  config = function()
    vim.g.go_gopls_enabled = 0
  end,
}
