return {
  'saghen/blink.cmp',
  lazy = false, -- lazy loading handled internally
  priority = 100, -- Load before LSP config to ensure capabilities are available
  -- optional: provides snippets for the snippet source
  dependencies = {
    'onsails/lspkind.nvim',
    'rafamadriz/friendly-snippets',
    { 'L3MON4D3/LuaSnip', version = 'v2.*' },
    'neovim/nvim-lspconfig',
  },
  commit = '*',
  config = function()
    local blink = require 'blink.cmp'
    local lspkind = require 'lspkind'

    -- Load friendly-snippets
    require('luasnip.loaders.from_vscode').lazy_load()

    -- Load our custom LuaSnip snippets
    require('snippets').setup()

    blink.setup {
      cmdline = {
        enabled = true,
      },

      snippets = { preset = 'luasnip' },
      completion = {
        documentation = {
          auto_show = true,
        },
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
            opts = {
              prefix_min_len = 2, -- Minimum length to trigger Conjure completions
              filetype_filter = {
                -- Only enable in Clojure and ClojureScript files
                include = { "clojure", "clojurescript" },
              },
            },
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
