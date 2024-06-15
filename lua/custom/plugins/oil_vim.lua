return {
  'stevearc/oil.nvim',
  opts = {
    keymaps = {
      ['?'] = 'actions.show_help',
      ['<CR>'] = 'actions.select',
      ['S'] = 'actions.select_vsplit',
      ['s'] = 'actions.select_split',
      ['<C-t>'] = 'actions.select_tab',
      ['P'] = 'actions.preview',
      ['q'] = 'actions.close',
      ['R'] = 'actions.refresh',
      ['<bs>'] = 'actions.parent',
      ['_'] = 'actions.open_cwd',
      ['`'] = 'actions.cd',
      ['~'] = 'actions.tcd',
      ['gs'] = 'actions.change_sort',
      ['O'] = 'actions.open_external',
      ['H'] = 'actions.toggle_hidden',
      ['g\\'] = 'actions.toggle_trash',
    },
  },
  -- Optional dependencies
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    require('oil').setup {
      delete_to_trash = true,
      skip_confirm_for_simple_edits = true,
      view_options = {
        show_hidden = true,
        natural_order = true,
        is_always_hidden = function(name)
          return name == '..' or name == '.git'
        end,
      },
    }
  end,
}
