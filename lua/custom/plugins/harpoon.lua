function shallow_copy_list(original)
  local copy = {}
  for i = 1, #original do
    copy[i] = original[i]
  end
  return copy
end

return {
  'ThePrimeagen/harpoon',
  enabled = true,
  branch = 'harpoon2',
  dependencies = { 'nvim-lua/plenary.nvim', 'nvim-telescope/telescope.nvim' },
  config = function()
    local harpoon = require 'harpoon'
    harpoon:setup()

    -- basic telescope configuration
    -- local conf = require('telescope.config').values
    -- local function toggle_telescope(harpoon_files)
    --   local file_paths = {}
    --   for _, item in ipairs(harpoon_files.items) do
    --     table.insert(file_paths, item.value)
    --   end
    --
    --   require('telescope.pickers')
    --     .new({}, {
    --       prompt_title = 'Harpoon',
    --       finder = require('telescope.finders').new_table {
    --         results = file_paths,
    --       },
    --       previewer = conf.file_previewer {},
    --       sorter = conf.generic_sorter {},
    --     })
    --     :find()
    -- end

    vim.keymap.set('n', '<leader>ba', function()
      harpoon:list():add()
    end, { desc = '[A]dd Buffer to list' })
    vim.keymap.set('n', '<leader>bk', function()
      harpoon:list():remove()
    end, { desc = '[D]elete Buffer from list' })

    vim.keymap.set('n', '<leader>bK', function()
      harpoon:list():clear()
    end, { desc = 'Open harpoon [L]ist' })

    vim.keymap.set('n', '<leader>bl', function()
      harpoon.ui:toggle_quick_menu(harpoon:list())
    end, { desc = 'Open harpoon [L]ist' })

    vim.keymap.set('n', '<leader>bp', function()
      harpoon:list():prev()
    end, { desc = 'Go to [P]revious' })
    vim.keymap.set('n', '<leader>bn', function()
      harpoon:list():next()
    end, { desc = 'Go to [N]ext' })
  end,
}
