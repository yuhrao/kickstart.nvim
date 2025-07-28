-- Neo-tree is a Neovim plugin to browse the file system
-- https://github.com/nvim-neo-tree/neo-tree.nvim

return {
  'nvim-neo-tree/neo-tree.nvim',
  version = '*',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
    'MunifTanjim/nui.nvim',
    's1n7ax/nvim-window-picker',
  },
  lazy = false,
  keys = {
    { '\\', ':Neotree reveal<CR>', desc = 'NeoTree reveal', silent = true },
  },
  opts = {
    window = {
      position = 'right',
      mappings = {
        ['\\'] = 'close_window',
        ['Y'] = 'none',
      },
    },
    filesystem = {
      filtered_items = {
        hide_dotfiles = false,
        hide_by_name = {
          '.git',
          '.DS_Store',
        },
        always_show = {
          '.env',
        },
      },
    },
  },
}
