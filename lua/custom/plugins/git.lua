return {
  'NeogitOrg/neogit',
  dependencies = {
    'nvim-lua/plenary.nvim', -- required
    'sindrets/diffview.nvim', -- optional - Diff integration
    'ruifm/gitlinker.nvim',

    -- Only one of these is needed, not both.
    'nvim-telescope/telescope.nvim', -- optional
    'ibhagwan/fzf-lua', -- optional
    'f-person/git-blame.nvim',
  },
  config = function()
    local neogit = require 'neogit'
    neogit.setup {}

    require('which-key').register {
      ['<leader>g'] = { name = '[G]it', _ = 'which_key_ignore' },
    }

    vim.keymap.set('n', '<leader>gs', function()
      neogit.open()
    end, { noremap = true, silent = true, desc = '[S]tatus' })

    vim.keymap.set('n', '<leader>gb', ':Telescope git_branches<CR>', { noremap = true, silent = true, desc = '[B]ranches' })

    require('gitblame').setup {
      enabled = true,
    }
    local gitlinker = require 'gitlinker'
    gitlinker.setup()

    vim.keymap.set('n', '<leader>gy', function()
      gitlinker.get_buf_range_url 'n'
    end, { noremap = true, silent = true, desc = '[G]it [Y]ank git URL' })
  end,
}
