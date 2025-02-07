-- Helper function to check if a table is list-like (an array)
local function is_array(t)
  if type(t) ~= 'table' then
    return false
  end
  local count = 0
  for k, _ in pairs(t) do
    if type(k) ~= 'number' then
      return false
    end
    count = count + 1
  end
  return count == #t
end

-- A helper transform function as in your original config.
local default_transform = function(item)
  local file = item.file or ''
  local is_hidden = file:match '^%.' ~= nil
  local is_ignored = item.ignored == true
  if is_hidden or is_ignored then
    if file:match '^(.*[/\\])?%.env.*$' then
      return item
    else
      return false
    end
  end
  return item
end

-- Define all module settings in a local table.
local modules = {}

--------------------------
-- Explorer Module
--------------------------
modules.explorer = {
  config = {
    enabled = true,
    replace_netrw = true,
  },
  keymaps = {
    {
      '\\',
      function()
        Snacks.explorer.open()
      end,
      desc = 'Open Explorer',
    },
  },
}

--------------------------
-- Picker Module
--------------------------
modules.picker = {
  config = {
    enabled = true,
    sources = { explorer = {} },
  },
  keymaps = {
    history = {
      {
        '<leader>:',
        function()
          Snacks.picker.command_history()
        end,
        desc = 'Command History',
      },
      -- Duplicate mapping (as in your original config)
      {
        '<leader>sc',
        function()
          Snacks.picker.command_history()
        end,
        desc = 'Command History (duplicate)',
      },
    },
    buffers = {
      {
        '<leader><space>',
        function()
          Snacks.picker.buffers()
        end,
        desc = 'Buffers',
      },
    },
    files = {
      {
        '<leader>sc',
        function()
          Snacks.picker.files {
            cwd = vim.fn.stdpath 'config',
            transform = default_transform,
          }
        end,
        desc = 'Find Config File',
      },
      {
        '<leader>sf',
        function()
          Snacks.picker.files { transform = default_transform }
        end,
        desc = 'Find Files',
      },
      {
        '<leader>gf',
        function()
          Snacks.picker.git_files { transform = default_transform }
        end,
        desc = 'Find Git Files',
      },
      {
        '<leader>sr',
        function()
          Snacks.picker.recent { transform = default_transform }
        end,
        desc = 'Recent',
      },
    },
    git = {
      {
        '<leader>gc',
        function()
          Snacks.picker.git_log()
        end,
        desc = 'Git Log',
      },
    },
    grep = {
      {
        '<leader>sb',
        function()
          Snacks.picker.lines()
        end,
        desc = 'Buffer Lines',
      },
      {
        '<leader>sB',
        function()
          Snacks.picker.grep_buffers()
        end,
        desc = 'Grep Open Buffers',
      },
      {
        '<leader>sg',
        function()
          Snacks.picker.grep()
        end,
        desc = 'Grep',
      },
      {
        '<leader>sw',
        function()
          Snacks.picker.grep_word()
        end,
        mode = { 'n', 'x' },
        desc = 'Visual selection or word',
      },
    },
    registers = {
      {
        '<leader>"',
        function()
          Snacks.picker.registers()
        end,
        desc = 'Registers',
      },
    },
    autocmds = {
      {
        '<leader>sa',
        function()
          Snacks.picker.autocmds()
        end,
        desc = 'Autocmds',
      },
    },
    commands = {
      {
        '<leader>sC',
        function()
          Snacks.picker.commands()
        end,
        desc = 'Commands',
      },
    },
    diagnostics = {
      {
        '<leader>sd',
        function()
          Snacks.picker.diagnostics()
        end,
        desc = 'Diagnostics',
      },
    },
    help = {
      {
        '<leader>sh',
        function()
          Snacks.picker.help()
        end,
        desc = 'Help Pages',
      },
      {
        '<leader>sH',
        function()
          Snacks.picker.highlights()
        end,
        desc = 'Highlights',
      },
    },
    jumps = {
      {
        '<leader>sj',
        function()
          Snacks.picker.jumps()
        end,
        desc = 'Jumps',
      },
    },
    keymaps = {
      {
        '<leader>sk',
        function()
          Snacks.picker.keymaps()
        end,
        desc = 'Keymaps',
      },
    },
    loclist = {
      {
        '<leader>sl',
        function()
          Snacks.picker.loclist()
        end,
        desc = 'Location List',
      },
    },
    man = {
      {
        '<leader>sM',
        function()
          Snacks.picker.man()
        end,
        desc = 'Man Pages',
      },
    },
    marks = {
      {
        '<leader>sm',
        function()
          Snacks.picker.marks()
        end,
        desc = 'Marks',
      },
    },
    resume = {
      {
        '<leader>sR',
        function()
          Snacks.picker.resume()
        end,
        desc = 'Resume',
      },
    },
    qflist = {
      {
        '<leader>sq',
        function()
          Snacks.picker.qflist()
        end,
        desc = 'Quickfix List',
      },
    },
    projects = {
      {
        '<leader>qp',
        function()
          Snacks.picker.projects()
        end,
        desc = 'Projects',
      },
    },
    lsp = {
      {
        'gd',
        function()
          Snacks.picker.lsp_definitions()
        end,
        desc = 'Goto Definition',
      },
      {
        'gr',
        function()
          Snacks.picker.lsp_references()
        end,
        nowait = true,
        desc = 'References',
      },
      {
        'gI',
        function()
          Snacks.picker.lsp_implementations()
        end,
        desc = 'Goto Implementation',
      },
      {
        'gy',
        function()
          Snacks.picker.lsp_type_definitions()
        end,
        desc = 'Goto T[y]pe Definition',
      },
      {
        '<leader>ss',
        function()
          Snacks.picker.lsp_symbols()
        end,
        desc = 'LSP Symbols',
      },
      {
        'gD',
        function()
          Snacks.picker.lsp_type_definitions()
        end,
        desc = 'Goto T[y]pe Definition',
      },
    },
  },
}

--------------------------
-- Lazygit Module
--------------------------
modules.lazygit = {
  config = {
    enabled = true,
  },
  keymaps = {
    {
      '<leader>gl',
      function()
        Snacks.lazygit.log()
      end,
      desc = 'Lazygit Log (cwd)',
    },
    {
      '<leader>gs',
      function()
        Snacks.lazygit.open()
      end,
      desc = 'Lazygit',
    },
  },
}

--------------------------
-- Gitbrowse Module
--------------------------
modules.gitbrowse = {
  config = {
    enabled = true,
  },
  keymaps = {
    {
      '<leader>gB',
      function()
        Snacks.git.blame_line()
      end,
      desc = 'Git Blame Line',
    },
  },
}

--------------------------
-- Dashboard Module
--------------------------
modules.dashboard = {
  config = {
    enabled = true,
  },
  keymaps = {
    -- (No explicit dashboard keymaps provided)
  },
}

--------------------------
-- Bigfile Module
--------------------------
modules.bigfile = {
  config = {
    enabled = true,
  },
  keymaps = {
    -- (No explicit bigfile keymaps provided)
  },
}

--------------------------
-- Bufdelete Module
--------------------------
modules.bufdelete = {
  config = {
    enabled = true,
  },
  keymaps = {
    {
      '<leader>bd',
      function()
        Snacks.bufdelete()
      end,
      desc = '[B]uffer [D]elete',
    },
  },
}

--------------------------
-- Notifier Module
--------------------------
modules.notifier = {
  config = {
    enabled = true,
    timeout = 3000,
  },
  keymaps = {
    {
      '<leader>sn',
      function()
        Snacks.notifier.show_history()
      end,
      desc = 'Notification History',
    },
    {
      '<leader>nd',
      function()
        Snacks.notifier.hide()
      end,
      desc = 'Dismiss All Notifications',
    },
  },
}

--------------------------
-- Statuscolumn Module
--------------------------
modules.statuscolumn = {
  config = {
    enabled = true,
  },
  keymaps = {
    -- (No explicit statuscolumn keymaps provided)
  },
}

--------------------------
-- Toggle Module
--------------------------
modules.toggle = {
  config = {
    enabled = true,
  },
  keymaps = {
    {
      '<leader>ts',
      function()
        Snacks.toggle.option('spell', { name = 'Spelling' }):toggle()
      end,
      desc = 'Toggle Spelling',
    },
    {
      '<leader>tw',
      function()
        Snacks.toggle.option('wrap', { name = 'Wrap' }):toggle()
      end,
      desc = 'Toggle Wrap',
    },
    {
      '<leader>tL',
      function()
        Snacks.toggle.option('relativenumber', { name = 'Relative Number' }):toggle()
      end,
      desc = 'Toggle Relative Number',
    },
    {
      '<leader>td',
      function()
        Snacks.toggle.diagnostics():toggle()
      end,
      desc = 'Toggle Diagnostics',
    },
    {
      '<leader>tl',
      function()
        Snacks.toggle.line_number():toggle()
      end,
      desc = 'Toggle Line Number',
    },
    {
      '<leader>tC',
      function()
        Snacks.toggle
          .option('conceallevel', {
            off = 0,
            on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2,
          })
          :toggle()
      end,
      desc = 'Toggle Conceallevel',
    },
    {
      '<leader>tT',
      function()
        Snacks.toggle.treesitter():toggle()
      end,
      desc = 'Toggle Treesitter',
    },
    {
      '<leader>tb',
      function()
        Snacks.toggle
          .option('background', {
            off = 'light',
            on = 'dark',
            name = 'Dark Background',
          })
          :toggle()
      end,
      desc = 'Toggle Background',
    },
    {
      '<leader>th',
      function()
        Snacks.toggle.inlay_hints():toggle()
      end,
      desc = 'Toggle Inlay Hints',
    },
  },
}

--------------------------
-- Terminal Module
--------------------------
modules.terminal = {
  config = {
    enabled = true,
  },
  keymaps = {
    -- (No explicit terminal keymaps provided)
  },
}

--------------------------
-- Quickfile Module
--------------------------
modules.quickfile = {
  config = {
    enabled = true,
  },
  keymaps = {
    -- (No explicit quickfile keymaps provided)
  },
}

--------------------------
-- Words Module
--------------------------
modules.words = {
  config = {
    enabled = true,
  },
  keymaps = {
    -- (No explicit words keymaps provided)
  },
}

--------------------------
-- Styles Module
--------------------------
modules.styles = {
  config = {
    notification = {
      wo = { wrap = true },
    },
  },
  keymaps = {
    -- (No explicit styles keymaps provided)
  },
}

--------------------------
-- Zen Module
--------------------------
modules.zen = {
  config = {
    enabled = true,
  },
  keymaps = {
    {
      '<leader>tz',
      function()
        Snacks.zen.zen()
      end,
      desc = '[T]oggle [Z]en',
    },
  },
  -- Example module-specific init function for Zen.
  init = function()
    -- Add any Zen-specific initialization here.
    -- For example, you might set up some variables or commands.
    -- vim.notify("Initializing Zen module")
  end,
}

-----------------------------------------------------------
-- Global / Overall Initialization
--
-- The following function (stored as modules.init) contains
-- initialization code that isn’t specific to a single module.
-- It also calls any module-specific init functions in the proper sequence.
-----------------------------------------------------------
modules.init = function()
  -- Global initialization from your lazy config:
  vim.api.nvim_create_autocmd('User', {
    pattern = 'VeryLazy',
    callback = function()
      _G.dd = function(...)
        Snacks.debug.inspect(...)
      end
      _G.bt = function()
        Snacks.debug.backtrace()
      end
      vim.print = _G.dd

      -- Create some toggle mappings:
      Snacks.toggle.option('spell', { name = 'Spelling' }):map '<leader>ts'
      Snacks.toggle.option('wrap', { name = 'Wrap' }):map '<leader>tw'
      Snacks.toggle.option('relativenumber', { name = 'Relative Number' }):map '<leader>tL'
      Snacks.toggle.diagnostics():map '<leader>td'
      Snacks.toggle.line_number():map '<leader>tl'
      Snacks.toggle.option('conceallevel', { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 }):map '<leader>tC'
      Snacks.toggle.treesitter():map '<leader>tT'
      Snacks.toggle.option('background', { off = 'light', on = 'dark', name = 'Dark Background' }):map '<leader>tb'
      Snacks.toggle.inlay_hints():map '<leader>th'
    end,
  })

  local prev = { new_name = '', old_name = '' }
  vim.api.nvim_create_autocmd('User', {
    pattern = 'NvimTreeSetup',
    callback = function()
      local events = require('nvim-tree.api').events
      events.subscribe(events.Event.NodeRenamed, function(data)
        if prev.new_name ~= data.new_name or prev.old_name ~= data.old_name then
          Snacks.rename.on_rename_file(data.old_name, data.new_name)
        end
      end)
    end,
  })

  -- Call each module's init function (if defined), except the global one.
  for name, mod in pairs(modules) do
    if name ~= 'init' and mod.init and type(mod.init) == 'function' then
      mod.init()
    end
  end
end

-----------------------------------------------------------
-- Functions to Consolidate Options and Merge Keymaps
-----------------------------------------------------------

local function consolidate_opts()
  local consolidated = {}
  for name, mod in pairs(modules) do
    if name ~= 'init' and mod.config then
      consolidated[name] = mod.config
    end
  end
  return consolidated
end

local function merge_keymaps()
  local merged = {}
  for name, mod in pairs(modules) do
    if name ~= 'init' and mod.keymaps then
      if is_array(mod.keymaps) then
        for _, mapping in ipairs(mod.keymaps) do
          table.insert(merged, mapping)
        end
      else
        for _, group in pairs(mod.keymaps) do
          if type(group) == 'table' then
            for _, mapping in ipairs(group) do
              table.insert(merged, mapping)
            end
          end
        end
      end
    end
  end
  return merged
end

-----------------------------------------------------------
-- Exported Functions
--
--  - opts() returns the consolidated module options.
--  - keymaps() returns all merged keymaps.
--  - init() calls the global initialization function.
-----------------------------------------------------------
return {
  opts = consolidate_opts,
  keymaps = merge_keymaps,
  init = modules.init,
}
