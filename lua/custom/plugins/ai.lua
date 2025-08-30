return {
  {
    'NickvanDyke/opencode.nvim',
    dependencies = {
      -- Recommended for better prompt input, and required to use opencode.nvim's embedded terminal. Otherwise optional.
      { 'folke/snacks.nvim', opts = { input = { enabled = true } } },
    },
    ---@type opencode.Opts
    opts = {
      -- Your configuration, if any
    },
    keys = {
      -- Recommended keymaps
      {
        '<leader>oA',
        function()
          require('opencode').ask()
        end,
        desc = 'Ask opencode',
      },
      {
        '<leader>oa',
        function()
          require('opencode').ask '@cursor: '
        end,
        desc = 'Ask opencode about this',
        mode = 'n',
      },
      {
        '<leader>oa',
        function()
          require('opencode').ask '@selection: '
        end,
        desc = 'Ask opencode about selection',
        mode = 'v',
      },
      {
        '<leader>ot',
        function()
          require('opencode').toggle()
        end,
        desc = 'Toggle embedded opencode',
      },
      {
        '<leader>on',
        function()
          require('opencode').command 'session_new'
        end,
        desc = 'New session',
      },
      {
        '<leader>oy',
        function()
          require('opencode').command 'messages_copy'
        end,
        desc = 'Copy last message',
      },
      {
        '<S-C-u>',
        function()
          require('opencode').command 'messages_half_page_up'
        end,
        desc = 'Scroll messages up',
      },
      {
        '<S-C-d>',
        function()
          require('opencode').command 'messages_half_page_down'
        end,
        desc = 'Scroll messages down',
      },
      {
        '<leader>op',
        function()
          require('opencode').select_prompt()
        end,
        desc = 'Select prompt',
        mode = { 'n', 'v' },
      },
      -- Example: keymap for custom prompt
      {
        '<leader>oe',
        function()
          require('opencode').prompt 'Explain @cursor and its context'
        end,
        desc = 'Explain code near cursor',
      },
    },
  },
  {
    'Exafunction/windsurf.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'saghen/blink.cmp',
    },
    config = function()
      require('codeium').setup {
        -- Optionally disable cmp source if using virtual text only
        enable_cmp_source = false,
        virtual_text = {
          enabled = true,

          -- These are the defaults

          -- Set to true if you never want completions to be shown automatically.
          manual = false,
          -- A mapping of filetype to true or false, to enable virtual text.
          filetypes = {},
          -- Whether to enable virtual text of not for filetypes not specifically listed above.
          default_filetype_enabled = true,
          -- How long to wait (in ms) before requesting completions after typing stops.
          idle_delay = 75,
          -- Priority of the virtual text. This usually ensures that the completions appear on top of
          -- other plugins that also add virtual text, such as LSP inlay hints, but can be modified if
          -- desired.
          virtual_text_priority = 65535,
          -- Set to false to disable all key bindings for managing completions.
          map_keys = true,
          -- The key to press when hitting the accept keybinding but no completion is showing.
          -- Defaults to \t normally or <c-n> when a popup is showing.
          accept_fallback = nil,
          -- Key bindings for managing completions in virtual text mode.
          key_bindings = {
            -- Accept the current completion.
            accept = '<Tab>',
            -- Accept the next word.
            accept_word = false,
            -- Accept the next line.
            accept_line = false,
            -- Clear the virtual text.
            clear = false,
            -- Cycle to the next completion.
            next = '<M-]>',
            -- Cycle to the previous completion.
            prev = '<M-[>',
          },
        },
      }
    end,
  },
}
