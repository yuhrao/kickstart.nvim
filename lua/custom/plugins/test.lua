return {
  {
    'nvim-neotest/neotest',
    dependencies = {
      'nvim-neotest/neotest-jest',
      'marilari88/neotest-vitest',
      'nvim-neotest/nvim-nio',
      'nvim-lua/plenary.nvim',
      'antoinemadec/FixCursorHold.nvim',
      'nvim-treesitter/nvim-treesitter',
    },
    opts = function(_, opts)
      opts = opts or {}
      opts.adapters = opts.adapters or {}
      table.insert(opts.adapters, require 'neotest-jest')
      table.insert(opts.adapters, require 'neotest-vitest')
      return opts
    end,
  },
}
