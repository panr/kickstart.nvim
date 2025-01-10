local colors = {
  -- gray = '#a89984',
  black = '#282828',
  normal = '#a4a4a4',
  insert = '#f4bb40',
  visual = '#ec72ca',
  command = '#86e4a3',
  replace = '#fd7c6d',
  bbg = '#3b3b3b',
  cbg = '#2a2a2a',
  fg = '#8e8e8e',
}

local custom_theme = {
  normal = {
    a = { bg = colors.normal, fg = colors.black, gui = 'bold' },
    b = { bg = colors.bbg, fg = colors.fg },
    c = { bg = colors.cbg, fg = colors.fg },
  },
  insert = { a = { bg = colors.insert, fg = colors.black, gui = 'bold' } },
  visual = { a = { bg = colors.visual, fg = colors.black, gui = 'bold' } },
  replace = { a = { bg = colors.replace, fg = colors.black, gui = 'bold' } },
  command = { a = { bg = colors.command, fg = colors.black, gui = 'bold' } },
  inactive = {
    a = { bg = colors.bbg, fg = colors.fg, gui = 'bold' },
    b = { bg = colors.bbg, fg = colors.fg },
    c = { bg = colors.cbg, fg = colors.fg },
  },
}

return {
  -- Set lualine as statusline
  'nvim-lualine/lualine.nvim',

  -- See `:help lualine.txt`
  opts = {
    options = {
      theme = custom_theme,
      icons_enabled = false,
      component_separators = '|',
      section_separators = '',
    },
  },
}
