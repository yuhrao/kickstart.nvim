local clj = require 'lib.clojure'

return {
  {
    'm00qek/baleia.nvim',
    version = '*',
    config = clj.setup_baleia,
  },
  {
    'Olical/conjure',
    ft = { 'clojure' }, -- etc
    dependencies = {
      'm00qek/baleia.nvim',
    },
    config = clj.config,
    init = clj.init,
  },
  {
    'PaterJason/nvim-treesitter-sexp',
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
    },
  },
}
