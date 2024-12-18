return {
  'epwalsh/obsidian.nvim',
  version = '*', -- recommended, use latest release instead of latest commit
  lazy = true,
  ft = 'markdown',
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  config = function()
    require('obsidian').setup {
      daily_notes = {
        -- Optional, if you keep daily notes in a separate directory.
        folder = 'journal',
        -- Optional, if you want to change the date format for the ID of daily notes.
        date_format = '%Y-%m-%d',
        -- Optional, if you want to change the date format of the default alias of daily notes.
        alias_format = '%B %-d, %Y',
        -- Optional, default tags to add to each new daily note created.
        default_tags = { 'daily-notes' },
        -- Optional, if you want to automatically insert a template from your template directory like 'daily.md'
        template = 'journal',
      },
      -- Optional, for templates (see below).
      templates = {
        folder = '~/vaults/common/templates',
        -- A map for custom variables, the key should be the variable and the value a function
        substitutions = {},
      },
      ui = { enable = false },
      workspaces = {
        {
          name = 'personal',
          path = '~/vaults/personal',
        },
        {
          name = 'nubank',
          path = '~/vaults/nubank',
        },
      },
    }
  end,
}
