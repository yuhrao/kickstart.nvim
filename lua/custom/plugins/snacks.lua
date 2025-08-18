return {
  'folke/snacks.nvim',
  priority = 1000,
  lazy = false,
  opts = {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
    bigfile = { enabled = true },
    bufdelete = { enabled = true },
    dashboard = { enabled = true },
    explorer = { enabled = false },   -- Keep disabled, using Neo-tree
    indent = { enabled = true },
    input = { enabled = true },
    lazygit = { enabled = true },
    notifier = { enabled = true },
    picker = { enabled = false },     -- Keep disabled, using Telescope
    quickfile = { enabled = true },
    scope = { enabled = true },
    scroll = {
      enabled = false,
      animate = {
        duration = { step = 30, total = 250 },
        easing = 'linear',
      },
      -- faster animation when repeating scroll after delay
      animate_repeat = {
        delay = 100, -- delay in ms before using the repeat animation
        duration = { step = 10, total = 50 },
        easing = 'linear',
      },
    },
    statuscolumn = { enabled = true },
    words = { enabled = true },
  },
  keys = {
    {
      '<leader>bd',
      mode = { 'n', 'x', 'o' },
      function()
        require('snacks').bufdelete.delete()
      end,
      desc = '[B]uffer [D]elete Current',
    },
    {
      ']]',
      function()
        require('snacks').words.jump(vim.v.count1)
      end,
      desc = 'Next Reference',
      mode = { 'n', 't' },
    },
    {
      '[[',
      function()
        require('snacks').words.jump(-vim.v.count1)
      end,
      desc = 'Prev Reference',
      mode = { 'n', 't' },
    },
    {
      '<leader>lg',
      function()
        require('snacks').lazygit.open()
      end,
      desc = '[L]azy [G]it',
      mode = { 'n', 't' },
    },
  },
}
