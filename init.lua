--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used) <leader>
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

require 'plugins'
require 'vim-options'
require 'commands'
require 'scripts'
require 'mappings'

-- Neovide settings
if vim.g.neovide then
  require 'neovide'
end

-- The line beneath this is called `modeline`. See `:hhelp modeline`elp modeline`
-- vim: ts=2 sts=2 sw=2 et
