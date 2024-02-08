return {
  'nvim-tree/nvim-tree.lua',
  dependencies = {
    'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
  },
  config = function()
    -- disable netrw at the very start of your init.lua (strongly advised)
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1
    -- set termguicolors to enable highlight groups
    vim.opt.termguicolors = true

    vim.keymap.set('n', '<C-n>', require('nvim-tree.api').tree.toggle, {
      noremap = true,
      silent = true,
      nowait = true,
    })

    -- Remap switching between panes
    -- Commented out due to issues with vim-navigator (but it works)
    -- vim.keymap.set('n', '<C-h>', '<C-w>h', { noremap = true, silent = true })
    -- vim.keymap.set('n', '<C-j>', '<C-w>j', { noremap = true, silent = true })
    -- vim.keymap.set('n', '<C-k>', '<C-w>k', { noremap = true, silent = true })
    -- vim.keymap.set('n', '<C-l>', '<C-w>l', { noremap = true, silent = true })

    require('nvim-tree').setup {
      sort_by = 'case_sensitive',
      renderer = {
        group_empty = true,
      },
      filters = {
        dotfiles = false,
        git_ignored = false,
      },
      on_attach = function(bufnr)
        local api = require 'nvim-tree.api'

        local function opts(desc)
          return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
        end

        api.config.mappings.default_on_attach(bufnr)

        vim.keymap.set('n', 'A', api.tree.expand_all, opts 'Expand All')
        vim.keymap.set('n', '?', api.tree.toggle_help, opts 'Help')
        vim.keymap.set('n', 'C', api.tree.change_root_to_node, opts 'CD')
        vim.keymap.set('n', 'P', function()
          local node = api.tree.get_node_under_cursor()
          print(node.absolute_path)
        end, opts 'Print Node Path')

        vim.keymap.set('n', 'Z', api.node.run.system, opts 'Run System')
      end,
    }
  end,
}
