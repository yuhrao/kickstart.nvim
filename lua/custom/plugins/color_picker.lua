return {
  'exosyphon/telescope-color-picker.nvim',
  dependencies = {
    { 'nvim-telescope/telescope.nvim' },
  },
  config = function()
    require('telescope').load_extension 'colors'
  end,
}
