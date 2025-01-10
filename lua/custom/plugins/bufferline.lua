return {
  'akinsho/bufferline.nvim',
  version = '*',
  dependencies = 'nvim-tree/nvim-web-devicons',
  config = function()
    local status, bufferline = pcall(require, 'bufferline')
    if not status then
      return
    end

    vim.opt.termguicolors = true
    local inactive_tab_fg = '#888888'

    -- vim.keymap.set('n', '[b', ':BufferLineCyclePrev<CR>', { desc = 'Go to previous tab / buffer' })
    -- vim.keymap.set('n', '[b', ':BufferLineCyclePrev<CR>', { desc = 'Go to previous tab / buffer' })
    vim.keymap.set('n', '<Tab>', ':BufferLineCycleNext<CR>', { desc = 'Go to next tab / buffer' })
    vim.keymap.set('n', '<S-Tab>', ':BufferLineCyclePrev<CR>', { desc = 'Go to previous tab / buffer' })

    bufferline.setup {
      options = {
        offsets = { {
          filetype = 'NvimTree',
          text = 'Nvim Tree',
          separator = true,
          text_align = 'left',
        } },
        style_preset = bufferline.style_preset.no_italic,
      },
      highlights = {
        background = {
          fg = inactive_tab_fg,
        },
        buffer = {
          fg = inactive_tab_fg,
        },
        tab = {
          fg = inactive_tab_fg,
        },
        tab_close = {
          fg = inactive_tab_fg,
        },
        close_button = {
          fg = inactive_tab_fg,
        },
      },
    }
  end,
}
