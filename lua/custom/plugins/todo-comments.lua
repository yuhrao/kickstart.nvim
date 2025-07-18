return {
  'folke/todo-comments.nvim',
  event = 'VimEnter',
  dependencies = { 'nvim-lua/plenary.nvim' },
  keys = {
    { '<leader>st', '<Cmd>TodoTelescope<CR>', mode = { 'n', 'x' }, desc = '[S]earch [T]odos' },
  },
  config = function()
    local colors = {
      error = vim.api.nvim_get_hl(0, { name = 'DiagnosticError' }).fg,
      warning = vim.api.nvim_get_hl(0, { name = 'DiagnosticWarn' }).fg,
      info = vim.api.nvim_get_hl(0, { name = 'DiagnosticInfo' }).fg,
      hint = vim.api.nvim_get_hl(0, { name = 'DiagnosticHint' }).fg,
      default = vim.api.nvim_get_hl(0, { name = 'Identifier' }).fg,
      test = vim.api.nvim_get_hl(0, { name = 'Special' }).fg,
    }

    require('todo-comments').setup {
      signs = false,
      colors = {
        error = { 'DiagnosticError', 'ErrorMsg', '#DC2626' },
        warning = { 'DiagnosticWarn', 'WarningMsg', '#FBBF24' },
        info = { 'DiagnosticInfo', '#2563EB' },
        hint = { 'DiagnosticHint', '#10B981' },
        default = { 'Identifier', '#7C3AED' },
        test = { 'Special', '#FF00FF' },
      },
      highlight = {
        keyword = 'fg',
        after = 'fg',
        pattern = [[.*<(KEYWORDS)\s*:]], -- pattern or table of patterns, used for highlighting (vim regex)
      },
      keywords = {
        FIX = {
          icon = ' ', -- icon used for the sign, and in search results
          color = 'error', -- can be a hex color, or a named color (see below)
          alt = { 'FIXME', 'BUG', 'FIXIT', 'ISSUE' }, -- a set of other keywords that all map to this FIX keywords
        },
        TODO = { icon = ' ', color = 'info' },
        HACK = { icon = ' ', color = 'warning' },
        WARN = { icon = ' ', color = 'warning', alt = { 'WARNING', 'XXX' } },
        PERF = { icon = ' ', color = 'default', alt = { 'OPTIM', 'PERFORMANCE', 'OPTIMIZE' } },
        NOTE = { icon = ' ', color = 'hint', alt = { 'INFO' } },
        QUESTION = { icon = '?', color = 'warning' },
        TEST = { icon = '⏲ ', color = 'test', alt = { 'TESTING', 'PASSED', 'FAILED' } },
      },
    }
  end,
}
