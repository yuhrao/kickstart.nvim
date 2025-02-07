local g = {}

g.setup_keys = function()
  require('which-key').add {
    { '<leader>g', group = '[G]it' },
    { '<leader>g_', hidden = true },
  }
end

g.setup_keymap = function(neogit, gitlinker)
  vim.keymap.set('n', '<leader>gs', function()
    neogit.open()
  end, { noremap = true, silent = true, desc = '[S]tatus' })

  vim.keymap.set('n', '<leader>gb', ':Telescope git_branches<CR>', { noremap = true, silent = true, desc = '[B]ranches' })

  vim.keymap.set('n', '<leader>gy', function()
    gitlinker.get_buf_range_url 'n'
  end, { noremap = true, silent = true, desc = '[G]it [Y]ank git URL' })
end

g.setup_worktree = function()
  require('git-worktree').setup()
  require('telescope').load_extension 'git_worktree'
end

g.setup = function()
  local neogit = require 'neogit'
  neogit.setup {}

  require('gitblame').setup {
    enabled = false,
  }
  local gitlinker = require 'gitlinker'
  gitlinker.setup()

  g.setup_keymap(neogit, gitlinker)

  g.setup_worktree()
end

return g
