local git = require 'lib.git'
return {
  { 'f-person/git-blame.nvim', opts = { enable = false } },
  {
    'ThePrimeagen/git-worktree.nvim',
    config = git.setup_worktree,
  },
  {
    'pwntester/octo.nvim',
    cmd = 'Octo',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-tree/nvim-web-devicons',
    },
    config = function()
      require('octo').setup {
        enable_builtin = true,
        use_local_fs = true,
      }
      vim.treesitter.language.register('markdown', 'octo')
    end,
  },
}
