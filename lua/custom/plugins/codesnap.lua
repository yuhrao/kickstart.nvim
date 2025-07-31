return {
  'mistricky/codesnap.nvim',
  build = 'make build_generator',
  lazy = false,
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
