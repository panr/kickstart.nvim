return {
  'Mofiqul/vscode.nvim',
  priority = 1000,
  config = function()
    vim.cmd.colorscheme = 'vscode'

    require('vscode').setup {
      style = 'dark',
      highlights = {
        ['@parameter'] = { fg = '#abb2bf' },
      },
      group_overrides = {
        ['@string'] = { fg = '#98c379' },
      },
    }
    require('vscode').load()
  end,
}
