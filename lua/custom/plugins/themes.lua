local thm = require 'lib.themes'
return {
  -- Set high priority for all theme plugins
  { 'adamkali/vaporlush', dependencies = { 'rktjmp/lush.nvim' }, priority = 10000, lazy = false },
  { 'catppuccin/nvim', name = 'catppuccin', priority = 10000, lazy = false },
  { 'arcticicestudio/nord-vim', priority = 10000, lazy = false },
  { 'srcery-colors/srcery-vim', priority = 10000, lazy = false },
  { 'altercation/vim-colors-solarized', priority = 10000, lazy = false },
  { 'embark-theme/vim', name = 'embark', priority = 10000, lazy = false },
  {
    'daltonmenezes/aura-theme',
    lazy = false,
    priority = 10000,
    config = function(plugin)
      vim.opt.rtp:append(plugin.dir .. '/packages/neovim')
    end,
  },
  { 'matsuuu/pinkmare', priority = 10000, lazy = false },
  { 'morhetz/gruvbox', priority = 10000, lazy = false },
  { 'NLKNguyen/papercolor-theme', priority = 10000, lazy = false },
  { 'sainnhe/everforest', priority = 10000, lazy = false },
  { 'projekt0n/github-nvim-theme', priority = 10000, lazy = false },
  { 'folke/tokyonight.nvim', priority = 10000, lazy = false },
  { 'Shatur/neovim-ayu', priority = 10000, lazy = false },
  {
    'navarasu/onedark.nvim',
    priority = 10000,
    lazy = false,
    config = function()
      require('onedark').setup {}
    end,
  },
  {
    -- Plugin that contains theme management
    dir = vim.fn.stdpath 'config' .. '/lua/custom/local/dracula-pro-2',
    priority = 10000,
    lazy = false,
    config = function()
      -- Specify the interval in seconds when creating the ThemeManager
      local theme_change_interval_seconds = 60

      local theme_manager = thm.ThemeManager(theme_change_interval_seconds)

      -- Autocommand to print the current colorscheme
      vim.api.nvim_create_autocmd('ColorScheme', {
        pattern = '*',
        callback = function()
          if vim.g.colors_name then
            print('Current colorscheme is ' .. vim.g.colors_name)
          end
        end,
      })

      vim.opt.termguicolors = true

      -- Defer the initial execution until after all plugins are loaded
      vim.api.nvim_create_autocmd('User', {
        pattern = 'VeryLazy',
        callback = function()
          theme_manager.set_random_dark_theme()
          -- Start the timer after initial theme is set
          -- theme_manager.start_theme_timer()
        end,
      })

      -- Create Neovim commands to set random themes
      vim.api.nvim_create_user_command('RandomDarkTheme', function()
        theme_manager.set_random_dark_theme()
      end, {})

      vim.api.nvim_create_user_command('RandomLightTheme', function()
        theme_manager.set_random_light_theme()
      end, {})

      vim.api.nvim_create_user_command('TurnLightsOn', function()
        theme_manager.set_random_light_theme()
      end, {})

      -- Commands to start/stop the timer
      vim.api.nvim_create_user_command('StartThemeTimer', function()
        theme_manager.start_theme_timer()
        print 'Theme timer started.'
      end, {})

      vim.api.nvim_create_user_command('StopThemeTimer', function()
        theme_manager.stop_theme_timer()
        print 'Theme timer stopped.'
      end, {})
    end,
  },
}
