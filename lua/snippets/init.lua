local ls = require 'luasnip'

-- Configure LuaSnip
ls.config.set_config {
  history = true, -- Remember snippets that were exited
  updateevents = 'TextChanged,TextChangedI', -- Update as you type
  enable_autosnippets = false, -- No automatic snippets
  ext_opts = {
    [require('luasnip.util.types').choiceNode] = {
      active = {
        virt_text = { { '●', 'GruvboxOrange' } }, -- Show indicator for choice nodes
      },
    },
  },
}

-- Load each snippet file
require 'snippets.clojure'
require 'snippets.javascript'
require 'snippets.typescript'
require 'snippets.react'
require 'snippets.nextjs'

-- Key mappings function for use in keymaps
local function luasnip_keymaps()
  vim.keymap.set({ 'i', 's' }, '<C-j>', function()
    if ls.expand_or_jumpable() then
      ls.expand_or_jump()
    end
  end, { silent = true, desc = 'LuaSnip expand or jump forward' })

  vim.keymap.set({ 'i', 's' }, '<C-k>', function()
    if ls.jumpable(-1) then
      ls.jump(-1)
    end
  end, { silent = true, desc = 'LuaSnip jump backward' })

  vim.keymap.set({ 'i', 's' }, '<C-l>', function()
    if ls.choice_active() then
      ls.change_choice(1)
    end
  end, { silent = true, desc = 'LuaSnip cycle forward through choices' })

  vim.keymap.set({ 'i', 's' }, '<C-h>', function()
    if ls.choice_active() then
      ls.change_choice(-1)
    end
  end, { silent = true, desc = 'LuaSnip cycle backward through choices' })
end

return {
  setup = function()
    luasnip_keymaps()
  end,
}

