return {
  'mistricky/codesnap.nvim',
  build = 'make build_generator',
  lazy = false,
  keys = {
    { '<leader>cc', '<cmd>CodeSnap<cr>', mode = 'x', desc = 'Save selected code snapshot into clipboard' },
    { '<leader>ch', '<cmd>CodeSnapHighlight<cr>', mode = 'x', desc = 'Save selected code snapshot into clipboard' },
    { '<leader>cA', '<cmd>CodeSnapASCII<cr>', mode = 'x', desc = 'Save selected code snapshot into clipboard' },
  },
  opts = {
    bg_theme = 'sea',
    has_breadcrumbs = true,
    show_workspace = true,
    has_line_number = true,
    watermark = '',
    title = '',
    bg_x_padding = 20,
    bg_y_padding = 20,
  },
}
