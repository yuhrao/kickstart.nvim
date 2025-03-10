return {
  {
    'git@github.com:dracula-pro/vim.git',
    name = 'dracula-pro',
    priority = 10000,
    lazy = false,
    config = function()
      vim.opt.termguicolors = true
      
      vim.api.nvim_create_autocmd('User', {
        pattern = 'VeryLazy',
        callback = function()
          vim.cmd('colorscheme dracula_pro_van_helsing')
        end,
      })
    end,
  },
}
