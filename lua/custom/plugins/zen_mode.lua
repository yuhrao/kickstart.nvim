return {
  'folke/zen-mode.nvim',
  opts = {
    on_open = function(_)
      vim.o.foldcolumn = '0'
      vim.o.foldenable = false
    end,
    on_close = function()
      vim.o.foldcolumn = '1'
      vim.o.foldenable = true
    end,
  },
}
