return {
  'saghen/blink.cmp',
  lazy = false, -- lazy loading handled internally
  -- optional: provides snippets for the snippet source
  dependencies = {
    'onsails/lspkind.nvim',
    'rafamadriz/friendly-snippets',
    { 'L3MON4D3/LuaSnip', version = 'v2.*' },
  },
  version = '*',
  config = function()
    local blink = require 'blink.cmp'
    local lspkind = require 'lspkind'

    require('luasnip.loaders.from_snipmate').lazy_load { paths = { vim.fn.expand '~' .. '/.config/nvim/snippets' } }

    blink.setup {

      snippets = { preset = 'luasnip' },
      completion = {
        menu = {
          draw = {
            components = {
              kind_icon = {
                ellipsis = false,

                -- This controls what gets displayed in the menu item
                text = function(ctx)
                  -- Just return the icon:
                  -- return lspkind.symbolic(ctx.kind, { mode = 'symbol' })

                  -- Or return icon + text label:
                  return lspkind.symbolic(ctx.kind, { mode = 'symbol_text' })
                end,

                -- If you want to leverage highlight groups, you can do so with the
                -- standard nvim-cmp or CmpItemKind groups, e.g., "CmpItemKindText"
                highlight = function(ctx)
                  -- For example, you might return the same highlight group that
                  -- nvim-cmp uses for the item kind:
                  return 'CmpItemKind' .. ctx.kind
                end,
              },
            },
          },
        },
      },

      keymap = { preset = 'default' },

      appearance = {
        use_nvim_cmp_as_default = false,
        nerd_font_variant = 'mono',
      },

      sources = {

        default = {
          'lsp',
          'path',
          'buffer',
          'snippets',
          'conjure',
        },

        providers = {
          conjure = {
            name = 'conjure',
            module = 'lib.blink.conjure',
            opts = {},
          },
        },
      },
      signature = { enabled = true },
    }
  end,
  -- allows extending the enabled_providers array elsewhere in your config
  -- without having to redefine it
  opts_extend = { 'sources.default' },
}
