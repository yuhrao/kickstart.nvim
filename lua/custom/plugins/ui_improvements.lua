return {
  {
    'stevearc/dressing.nvim',
    config = function()
      require('dressing').setup {
        input = {
          -- Set to false to disable the vim.ui.input implementation
          enabled = true,

          -- Default prompt string
          default_prompt = 'Input',

          -- Trim trailing `:` from prompt
          trim_prompt = true,

          -- Can be 'left', 'right', or 'center'
          title_pos = 'left',

          -- When true, input will start in insert mode.
          start_in_insert = true,

          -- These are passed to nvim_open_win
          border = 'rounded',
          -- 'editor' and 'win' will default to being centered
          relative = 'cursor',

          -- These can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
          prefer_width = 40,
          width = nil,
          -- min_width and max_width can be a list of mixed types.
          -- min_width = {20, 0.2} means "the greater of 20 columns or 20% of total"
          max_width = { 140, 0.9 },
          min_width = { 20, 0.2 },

          buf_options = {},
          win_options = {
            -- Disable line wrapping
            wrap = false,
            -- Indicator for when text exceeds window
            list = true,
            listchars = 'precedes:…,extends:…',
            -- Increase this for more context when text scrolls off the window
            sidescrolloff = 0,
          },

          -- Set to `false` to disable
          mappings = {
            n = {
              ['<Esc>'] = 'Close',
              ['q'] = 'Close',
              ['<CR>'] = 'Confirm',
            },
            i = {
              ['<C-c>'] = 'Close',
              ['<CR>'] = 'Confirm',
              ['<C-p>'] = 'HistoryPrev',
              ['<C-n>'] = 'HistoryNext',
            },
          },

          override = function(conf)
            -- This is the config that will be passed to nvim_open_win.
            -- Change values here to customize the layout
            return conf
          end,

          -- see :help dressing_get_config
          get_config = nil,
        },
        select = {
          -- Set to false to disable the vim.ui.select implementation
          enabled = true,

          -- Priority list of preferred vim.select implementations
          backend = { 'telescope', 'fzf_lua', 'fzf', 'builtin', 'nui' },

          -- Trim trailing `:` from prompt
          trim_prompt = true,

          -- Options for telescope selector
          -- These are passed into the telescope picker directly. Can be used like:
          -- telescope = require('telescope.themes').get_ivy({...})
          telescope = nil,

          -- Options for fzf selector
          fzf = {
            window = {
              width = 0.5,
              height = 0.4,
            },
          },

          -- Options for fzf-lua
          fzf_lua = {
            -- winopts = {
            --   height = 0.5,
            --   width = 0.5,
            -- },
          },

          -- Options for nui Menu
          nui = {
            position = '50%',
            size = nil,
            relative = 'editor',
            border = {
              style = 'rounded',
            },
            buf_options = {
              swapfile = false,
              filetype = 'DressingSelect',
            },
            win_options = {
              winblend = 0,
            },
            max_width = 80,
            max_height = 40,
            min_width = 40,
            min_height = 10,
          },

          -- Options for built-in selector
          builtin = {
            -- Display numbers for options and set up keymaps
            show_numbers = true,
            -- These are passed to nvim_open_win
            border = 'rounded',
            -- 'editor' and 'win' will default to being centered
            relative = 'editor',

            buf_options = {},
            win_options = {
              cursorline = true,
              cursorlineopt = 'both',
            },

            -- These can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
            -- the min_ and max_ options can be a list of mixed types.
            -- max_width = {140, 0.8} means "the lesser of 140 columns or 80% of total"
            width = nil,
            max_width = { 140, 0.8 },
            min_width = { 40, 0.2 },
            height = nil,
            max_height = 0.9,
            min_height = { 10, 0.2 },

            -- Set to `false` to disable
            mappings = {
              ['<Esc>'] = 'Close',
              ['<C-c>'] = 'Close',
              ['<CR>'] = 'Confirm',
            },

            override = function(conf)
              -- This is the config that will be passed to nvim_open_win.
              -- Change values here to customize the layout
              return conf
            end,
          },

          -- Used to override format_item. See :help dressing-format
          format_item_override = {},

          -- see :help dressing_get_config
          get_config = nil,
        },
      }
    end,
  },
  {
    'NvChad/nvim-colorizer.lua',
    opts = {
      filetypes = { '*' },
      user_default_options = {
        mode = 'background',
        tailwind = true,
        RGB = true,
        RRGGBB = true,
        names = true,
        RRGGBBAA = true,
        rgb_fn = true,
        hsl_fn = true,
        css = true,
        css_fn = true,
      },
    },
  },
  {
    'nvim-lualine/lualine.nvim',
    config = function()
      require('lualine').setup {
        options = {
          theme = 'ayu_mirage',
          sections = {
            lualine_c = {
              {
                'filename',
                file_status = true,
                newfile_status = false,
                path = 2,

                shorting_target = 40,

                symbols = {
                  modified = '[+]',
                  readonly = '[-]',
                  unnamed = '[No Name]',
                  newfile = '[New]',
                },
              },
            },
          },
          inactive_sections = {
            lualine_c = {
              {
                'filename',
                file_status = true,
                newfile_status = false,
                path = 2,

                shorting_target = 40,

                symbols = {
                  modified = '[+]',
                  readonly = '[-]',
                  unnamed = '[No Name]',
                  newfile = '[New]',
                },
              },
            },
          },
        },
      }
    end,
  },
  {
    'b0o/incline.nvim',
    cond = not vim.g.vscode,
    event = 'BufReadPre',
    opts = {
      highlight = {
        groups = {
          InclineNormal = { default = true, group = 'lualine_a_normal' },
          InclineNormalNC = { default = true, group = 'lualine_a_normal' },
        },
      },
      window = { margin = { vertical = 0, horizontal = 1 } },
      render = function(props)
        local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ':t')
        local icon, color = require('nvim-web-devicons').get_icon_color(filename)
        return { { icon, guifg = color }, { icon and ' ' or '' }, { filename } }
      end,
      hide = {
        cursorline = false,
        focused_win = false,
        only_win = true,
      },
    },
  },
  {
    'sphamba/smear-cursor.nvim',
    opts = {
      -- How fast the smear's head moves towards the target.
      -- 0: no movement, 1: instantaneous, default: 0.6
      stiffness = 0.8,

      -- How fast the smear's tail moves towards the head.
      -- 0: no movement, 1: instantaneous, default: 0.3
      trailing_stiffness = 0.6,

      -- How much the tail slows down when getting close to the head.
      -- 0: no slowdown, more: more slowdown, default: 0.1
      trailing_exponent = 0,

      -- Stop animating when the smear's tail is within this distance (in characters) from the target.
      -- Default: 0.1
      distance_stop_animating = 0.5,

      -- Attempt to hide the real cursor when smearing.
      -- Default: true
      hide_target_hack = false,
    },
  },
  {
    'xiyaowong/transparent.nvim',
    config = function()
      require('transparent').setup {
        -- table: default groups
        groups = {
          'Normal',
          'NormalNC',
          'Comment',
          'Constant',
          'Special',
          'Identifier',
          'Statement',
          'PreProc',
          'Type',
          'Underlined',
          'Todo',
          'String',
          'Function',
          'Conditional',
          'Repeat',
          'Operator',
          'Structure',
          'LineNr',
          'NonText',
          'SignColumn',
          'CursorLine',
          'CursorLineNr',
          'StatusLine',
          'StatusLineNC',
          'EndOfBuffer',
        },
        -- table: additional groups that should be cleared
        extra_groups = {},
        -- table: groups you don't want to clear
        exclude_groups = {},
        -- function: code to be executed after highlight groups are cleared
        -- Also the user event "TransparentClear" will be triggered
        on_clear = function() end,
      }
    end,
  },
}
