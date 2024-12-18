return {
  {
    'mrshmllow/orgmode-babel.nvim',
    dependencies = {
      'nvim-orgmode/orgmode',
      'nvim-treesitter/nvim-treesitter',
    },
    cmd = { 'OrgExecute', 'OrgTangle' },
    opts = {
      -- by default, none are enabled
      langs = { 'shell' },
      -- paths to emacs packages to additionally load
      load_paths = {},
    },
  },
  {
    'nvim-orgmode/orgmode',
    event = 'VeryLazy',
    ft = { 'org' },
    config = function()
      -- Setup orgmode
      require('orgmode').setup {}

      -- NOTE: If you are using nvim-treesitter with `ensure_installed = "all"` option
      -- add `org` to ignore_install
      -- require('nvim-treesitter.configs').setup({
      --   ensure_installed = 'all',
      --   ignore_install = { 'org' },
      -- })
    end,
  },
}
