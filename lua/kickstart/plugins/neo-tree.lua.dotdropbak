-- Neo-tree is a Neovim plugin to browse the file system
-- https://github.com/nvim-neo-tree/neo-tree.nvim
--
local function copy_file_reference(state)
  -- NeoTree is based on [NuiTree](https://github.com/MunifTanjim/nui.nvim/tree/main/lua/nui/tree)
  -- The node is based on [NuiNode](https://github.com/MunifTanjim/nui.nvim/tree/main/lua/nui/tree#nuitreenode)
  local node = state.tree:get_node()
  local filepath = node:get_id()
  local filename = node.name
  local modify = vim.fn.fnamemodify

  local results = {
    modify(filepath, ':.'),
    filename,
    modify(filename, ':r'),
    filepath,
    modify(filepath, ':~'),
    modify(filename, ':e'),
  }

  vim.ui.select({
    '1. Path relative to CWD: ' .. results[1],
    '2. Filename: ' .. results[2],
    '3. Filename without extension: ' .. results[3],
    '4. Absolute path: ' .. results[4],
    '5. Path relative to HOME: ' .. results[5],
    '6. Extension of the filename: ' .. results[6],
  }, { prompt = 'Choose to copy to clipboard:' }, function(choice)
    local i = tonumber(choice:sub(1, 1))
    local result = results[i]
    vim.fn.setreg('+', result)
    vim.notify('Copied: ' .. result)
  end)
end

return {
  'nvim-neo-tree/neo-tree.nvim',
  version = '*',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
    'MunifTanjim/nui.nvim',
    '3rd/image.nvim', -- Optional image support in preview window: See `# Preview Mode` for more information
  },
  cmd = 'Neotree',
  keys = {
    -- { '\\', ':Neotree reveal<CR>', { desc = 'NeoTree reveal' } },
  },
  opts = function(_, _)
    local opts = {
      filesystem = {
        filtered_items = {
          hide_dotfiles = false,
          never_show = {
            '.vscode',
            '.git',
            '.lein-*',
          },
          always_show_by_pattern = { -- uses glob style patterns
            '.env*',
          },
        },
        window = {
          mappings = {
            ['\\'] = 'close_window',
          },
        },
        hide_dotfiles = false,
        hide_gitignored = false,
      },
      enable_git_status = true,
      enable_diagnostics = true,

      commands = {
        copy_file_reference = copy_file_reference,

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

    local function on_move(data)
      Snacks.rename.on_rename_file(data.source, data.destination)
    end
    local events = require 'neo-tree.events'
    opts.event_handlers = opts.event_handlers or {}

    vim.list_extend(opts.event_handlers, {
      { event = events.FILE_MOVED, handler = on_move },
      { event = events.FILE_RENAMED, handler = on_move },
    })
    return opts
  end,
}
