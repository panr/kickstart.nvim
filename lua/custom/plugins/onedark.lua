return {
  -- Theme inspired by Atom
  'navarasu/onedark.nvim',
  priority = 1000,
  config = function()
    vim.cmd.colorscheme 'onedark'

    require('onedark').setup {
      style = 'dark',
      transparent = true,
      highlights = {
        ['@parameter'] = { fg = '#abb2bf' },
      },
    }
    require('onedark').load()
  end,
}
