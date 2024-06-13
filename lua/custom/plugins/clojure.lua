return {
  'Olical/conjure',
  ft = { 'clojure' }, -- etc
  -- [Optional] cmp-conjure for cmp
  dependencies = {
    {
      'PaterJason/cmp-conjure',
      config = function()
        local cmp = require 'cmp'
        local config = cmp.get_config()
        table.insert(config.sources, {
          name = 'buffer',
          option = {
            sources = {
              { name = 'conjure' },
            },
          },
        })
        cmp.setup(config)
      end,
    },
  },
  config = function(_, _)
    require('conjure.main').main()
    require('conjure.mapping')['on-filetype']()
  end,
  init = function()
    -- Set configuration options here
    vim.g['conjure#debug'] = false
    vim.g['conjure#client#clojure#nrepl#mapping#session_fresh'] = 'rf'
    vim.g['conjure#client_on_load'] = false
    vim.g['conjure#mapping#doc_word'] = false
    vim.g['conjure#extract#tree_sitter#enabled'] = true
  end,
}
