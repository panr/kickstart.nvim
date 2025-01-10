local function natural_cmp(left, right)
  -- sort directories firts
  if left.type ~= 'directory' and right.type == 'directory' then
    return false
  elseif left.type == 'directory' and right.type ~= 'directory' then
    return true
  end

  left = left.name:lower()
  right = right.name:lower()

  if left == right then
    return false
  end

  -- sort dotfiles and _ after the directories
  if string.find(left, '^[._]', 1, false) == nil and string.find(right, '^[._]', 1, false) ~= nil then
    return false
  elseif string.find(left, '^[._]', 1, false) ~= nil and string.find(right, '^[._]', 1, false) == nil then
    return true
  end

  for i = 1, math.max(string.len(left), string.len(right)), 1 do
    local l = string.sub(left, i, -1)
    local r = string.sub(right, i, -1)

    if type(tonumber(string.sub(l, 1, 1))) == 'number' and type(tonumber(string.sub(r, 1, 1))) == 'number' then
      local l_number = tonumber(string.match(l, '^[0-9]+'))
      local r_number = tonumber(string.match(r, '^[0-9]+'))

      if l_number ~= r_number then
        return l_number < r_number
      end
    elseif string.sub(l, 1, 1) ~= string.sub(r, 1, 1) then
      return l < r
    end
  end
end

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
      sort_by = function(nodes)
        table.sort(nodes, natural_cmp)
      end,
      renderer = {
        group_empty = true,
      },
      filters = {
        dotfiles = false,
        git_ignored = false,
      },
      diagnostics = {
        enable = true,
        show_on_dirs = true,
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
