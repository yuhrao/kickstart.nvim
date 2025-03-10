local snacks = require 'lib.snacks'
return {
  'folke/snacks.nvim',
  priority = 1000,
  dependencies = {
    's1n7ax/nvim-window-picker',
    'nvim-neo-tree/neo-tree.nvim',
  },
  lazy = false,
  opts = snacks.opts(),
  init = snacks.init,
  keys = snacks.keymaps(),
}
