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

    vim.keymap.set('n', '[b', ':BufferLineCyclePrev<CR>', { desc = 'Go to previous tab / buffer' })
    vim.keymap.set('n', ']b', ':BufferLineCycleNext<CR>', { desc = 'Go to next tab / buffer' })

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
    }
  end,
}
