vim.keymap.set('n', '<leader>G', '<C-G>', { desc = 'Show full path of a file' })
vim.keymap.set('n', '<leader>t', function()
  ToggleTerminal()
end, { desc = 'Toggle terminal buffer' })
