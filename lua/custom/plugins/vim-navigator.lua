return {
  'christoomey/vim-tmux-navigator',
  version = '*',
  config = function()
    local status, navigator = pcall(require, 'vim-tmux-navigator')
    if not status then
      return
    end

    vim.keymap.set('n', '<C-h>', ':TmuxNavigatorLeft<CR>', { desc = 'Window Left', noremap = true, silent = true })
    vim.keymap.set('n', '<C-l>', ':TmuxNavigatorRight<CR>', { desc = 'Window Right', noremap = true, silent = true })
    vim.keymap.set('n', '<C-j>', ':TmuxNavigatorDown<CR>', { desc = 'Window Down', noremap = true, silent = true })
    vim.keymap.set('n', '<C-k>', ':TmuxNavigatorUp<CR>', { desc = 'Window Up', noremap = true, silent = true })
  end,
}
