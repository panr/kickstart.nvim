vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.o.hlsearch = true
vim.api.nvim_set_hl(0, 'Search', { bg = '#cccccc', fg = '#000000' })
vim.wo.number = true
vim.o.mouse = 'a'
vim.o.clipboard = 'unnamedplus'
vim.o.breakindent = true
vim.o.undofile = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.wo.signcolumn = 'yes'
vim.o.updatetime = 250
vim.o.timeout = true
vim.o.timeoutlen = 300
vim.o.completeopt = 'menuone,noselect'
vim.o.termguicolors = true
vim.o.cursorline = true
vim.api.nvim_set_hl(0, 'CursorLine', { bg = '#222222' })

-- vim.opt.list = true
vim.opt.listchars:append 'space:⋅'
vim.opt.listchars:append 'eol:¶'
vim.opt.listchars:append 'tab:|-'
vim.opt.listchars:append 'trail:·'
vim.opt.listchars:append 'extends:>'
vim.opt.listchars:append 'precedes:<'
