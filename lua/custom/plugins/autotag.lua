return {
  'windwp/nvim-ts-autotag',
  dependencies = 'nvim-treesitter/nvim-treesitter',
  lazy = true,
  event = 'VeryLazy',
  config = function()
    local atag = require 'nvim-ts-autotag'
    atag.setup {
      aliases = {
        ['svelte'] = 'html',
        ['jsx'] = 'html',
        ['tsx'] = 'html',
      },
    }
  end,
}
