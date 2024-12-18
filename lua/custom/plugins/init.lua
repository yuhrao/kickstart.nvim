-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
  'AndrewRadev/splitjoin.vim',
  {
    'nat-418/boole.nvim',
    opts = {
      mappings = {
        increment = '<C-a>',
        decrement = '<C-x>',
      },
      -- User defined loops
      additions = {
        -- { "Foo", "Bar" },
        -- { "tic", "tac", "toe" },
      },
      allow_caps_additions = {
        { 'enable', 'disable' },
        -- enable → disable
        -- Enable → Disable
        -- ENABLE → DISABLE
      },
    },
  },
  -- Better symbol view for LSP
  {
    'liuchengxu/vista.vim',
    lazy = true,
    cmd = 'Vista',
    cond = not vim.g.vscode,
    config = function()
      vim.g.vista_default_executive = 'nvim_lsp'
    end,
  },
  {
    'gregorias/coerce.nvim',
    tag = 'v4.1.0',
    config = true,
  },
}
