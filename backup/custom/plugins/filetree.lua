return {
  {
    'stevearc/oil.nvim',
    opts = {
      keymaps = {
        ['?'] = 'actions.show_help',
        ['<CR>'] = 'actions.select',
        ['S'] = 'actions.select_vsplit',
        ['s'] = 'actions.select_split',
        ['<C-t>'] = 'actions.select_tab',
        ['P'] = 'actions.preview',
        ['q'] = 'actions.close',
        ['R'] = 'actions.refresh',
        ['<bs>'] = 'actions.parent',
        ['_'] = 'actions.open_cwd',
        ['`'] = 'actions.cd',
        ['~'] = 'actions.tcd',
        ['gs'] = 'actions.change_sort',
        ['O'] = 'actions.open_external',
        ['H'] = 'actions.toggle_hidden',
        ['g\\'] = 'actions.toggle_trash',
      },
    },
    -- Optional dependencies
    dependencies = { 'nvim-tree/nvim-web-devicons' },
  },

  {
    'nvim-neo-tree/neo-tree.nvim',
    branch = 'v3.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
      'MunifTanjim/nui.nvim',
      -- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
    },
    config = function()
      require('neo-tree').setup {
        filesystem = {
          hide_dotfiles = false,
          hide_gitignored = false,
        },
        open_on_setup = false,
        auto_close = true,
        update_to_buf_dir = {
          enable = true,
          auto_open = true,
        },
        view = {
          width = 30,
          side = 'left',
          auto_resize = true,
          mappings = {
            custom_only = false,
            list = {
              { key = { 'l', '<CR>', 'o', '<2-LeftMouse>' }, cb = '<CR>' },
              { key = 'h', cb = '<C-]>' },
              { key = 'q', cb = '<ESC>' },
            },
          },
        },
        commands = {
          copy_file_reference = function(state)
            -- NeoTree is based on [NuiTree](https://github.com/MunifTanjim/nui.nvim/tree/main/lua/nui/tree)
            -- The node is based on [NuiNode](https://github.com/MunifTanjim/nui.nvim/tree/main/lua/nui/tree#nuitreenode)
            local node = state.tree:get_node()
            local filepath = node:get_id()
            local filename = node.name
            local modify = vim.fn.fnamemodify

            local results = {
              filepath,
              modify(filepath, ':.'),
              modify(filepath, ':~'),
              filename,
              modify(filename, ':r'),
              modify(filename, ':e'),
            }

            vim.ui.select({
              '1. Absolute path: ' .. results[1],
              '2. Path relative to CWD: ' .. results[2],
              '3. Path relative to HOME: ' .. results[3],
              '4. Filename: ' .. results[4],
              '5. Filename without extension: ' .. results[5],
              '6. Extension of the filename: ' .. results[6],
            }, { prompt = 'Choose to copy to clipboard:' }, function(choice)
              local i = tonumber(choice:sub(1, 1))
              local result = results[i]
              vim.fn.setreg('+', result)
              vim.notify('Copied: ' .. result)
            end)
          end,

          reveal_in_file_explorer = function(state)
            local node = state.tree:get_node()
            local filepath = node:get_id()
            os.execute('open -R ' .. filepath)
          end,
        },
        window = {
          mappings = {
            ['O'] = 'reveal_in_file_explorer',
            ['Y'] = 'copy_file_reference',
          },
        },
      }

      vim.keymap.set('n', '<leader>op', ':Neotree toggle<CR>', { noremap = true, silent = true, desc = 'Open neotreee' })
    end,
  },
}
