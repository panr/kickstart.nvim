return {
  'lewis6991/gitsigns.nvim',
  -- Adds git releated signs to the gutter, as well as utilities for managing changes
  opts = {
    -- See `:help gitsigns.txt`
    signs = {
      add = { text = '+' },
      change = { text = '~' },
      delete = { text = '_' },
      topdelete = { text = '‾' },
      changedelete = { text = '~' },
    },
    current_line_blame = true,
  },
}
