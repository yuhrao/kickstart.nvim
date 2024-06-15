return {
  'ggandor/leap.nvim',
  dependencies = {
    'tpope/vim-repeat',
  },
  config = function()
    vim.keymap.set({ 'n', 'x', 'o' }, 'ss', '<Plug>(leap-forward)', { desc = '[L]eap Forward' })
    vim.keymap.set({ 'n', 'x', 'o' }, 'sS', '<Plug>(leap-backward)', { desc = '[L]eap Forward' })
    vim.keymap.set({ 'n', 'x', 'o' }, 'gss', '<Plug>(leap-from-window)', { desc = 'Leap from window' })
  end,
}
