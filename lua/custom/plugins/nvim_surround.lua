return {
  { 'nvim-treesitter/nvim-treesitter-textobjects', dependencies = { 'nvim-treesitter/nvim-treesitter' } },
  {
    'kylechui/nvim-surround',
    version = '*', -- Use for stability; omit to use `main` branch for the latest features
    event = 'VeryLazy',
    config = function()
      require('nvim-surround').setup {
        keymaps = {
          insert = '<C-g>s',
          insert_line = '<C-g>S',
          normal = 'sa',
          normal_cur = 'sA',
          normal_line = 'yS',
          normal_cur_line = 'ySS',
          visual = 'sa',
          visual_line = 'sA',
          delete = 'ds',
          change = 'cs',
          change_line = 'cS',
        },
      }
    end,
  },
}
