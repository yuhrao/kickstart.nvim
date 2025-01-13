local t = {}

local dark_themes = {
  -- Existing dark themes
  'vaporlush',
  'catppuccin',
  -- 'srcery',
  'embark',
  -- 'github_dark',
  'aura-dark',
  -- 'aura-dark-soft-text',
  'tokyonight',
  'catppuccin-macchiato',
  -- 'nord',
  -- 'aura-soft-dark-soft-text',
  'github_dark_dimmed',
  'tokyonight-moon',
  'tokyonight-night',
  'ayu-mirage',
  -- 'pinkmare',
  -- 'gruvbox',
  -- 'everforest',
  -- 'PaperColor',
  -- 'github_dark_default',
  -- 'onedark',
  'catppuccin-frappe',
  -- 'github_dark_high_contrast',
  'catppuccin-mocha',
  'tokyonight-storm',
  'ayu-dark',
  -- 'github_dark_tritanopia',
  -- 'aura-soft-dark',
  'cyberdream',
  'nightfox',
  'carbonfox',
  'duskfox',
}

local light_themes = {
  'catppuccin-latte',
  'solarized',
  'alucard',
  'everforest',
  'PaperColor',
  'github_light',
  'github_light_default',
  'github_light_high_contrast',
  'github_light_tritanopia',
  'tokyonight-day',
  'ayu-light',
  'onelight',
  'dayfox',
  'dawnfox',
}

t.ThemeManager = function(theme_change_interval_seconds)
  -- Default interval in seconds if none provided
  theme_change_interval_seconds = theme_change_interval_seconds or 900 -- 900 seconds = 15 minutes

  -- Initialize indices
  local dark_theme_index = 0
  local light_theme_index = 0

  -- Timer handle
  local theme_timer = nil

  -- Seed the random number generator once at startup
  math.randomseed(os.time() + vim.loop.getpid())

  -- Shuffle function
  local function shuffle(t)
    for i = #t, 2, -1 do
      local j = math.random(i)
      t[i], t[j] = t[j], t[i]
    end
  end

  -- Shuffle the themes
  shuffle(dark_themes)
  shuffle(light_themes)

  -- Define the ThemeManager object with its methods
  local manager = {}

  -- Function to set a random dark theme
  function manager.set_random_dark_theme()
    vim.opt.background = 'dark'
    dark_theme_index = dark_theme_index + 1

    -- Reshuffle and reset index if we've used all themes
    if dark_theme_index > #dark_themes then
      shuffle(dark_themes)
      dark_theme_index = 1
    end

    local selected_theme = dark_themes[dark_theme_index]

    -- Special handling for themes that require setup
    if selected_theme == 'ayu-dark' or selected_theme == 'ayu-mirage' then
      vim.g.ayu_mirage = selected_theme == 'ayu-mirage'
      vim.g.ayu_theme = 'dark'
    elseif selected_theme == 'onedark' then
      require('onedark').setup { style = 'dark' }
      require('onedark').load()
    else
      -- Try to apply the colorscheme
      local status_ok, _ = pcall(vim.cmd, 'colorscheme ' .. selected_theme)
      if not status_ok then
        vim.notify('Colorscheme ' .. selected_theme .. ' not found!', vim.log.levels.ERROR)
        return
      end
    end

    -- Manually set g:colors_name
    vim.g.colors_name = selected_theme

    print('Theme set to: ' .. selected_theme .. ' (dark)')
  end

  -- Function to set a random light theme
  function manager.set_random_light_theme()
    vim.opt.background = 'light'
    light_theme_index = light_theme_index + 1

    -- Reshuffle and reset index if we've used all themes
    if light_theme_index > #light_themes then
      shuffle(light_themes)
      light_theme_index = 1
    end

    local selected_theme = light_themes[light_theme_index]

    -- Special handling for themes that require setup
    if selected_theme == 'ayu-light' then
      vim.g.ayu_theme = 'light'
    elseif selected_theme == 'onelight' then
      require('onedark').setup { style = 'light' }
      require('onedark').load()
    else
      -- Try to apply the colorscheme
      local status_ok, _ = pcall(vim.cmd, 'colorscheme ' .. selected_theme)
      if not status_ok then
        vim.notify('Colorscheme ' .. selected_theme .. ' not found!', vim.log.levels.ERROR)
        return
      end
    end

    -- Manually set g:colors_name
    vim.g.colors_name = selected_theme

    print('Theme set to: ' .. selected_theme .. ' (light)')
  end

  -- Function to start the theme timer
  function manager.start_theme_timer()
    -- Convert seconds to milliseconds
    local interval_ms = theme_change_interval_seconds * 1000

    -- Stop any existing timer
    if theme_timer then
      theme_timer:stop()
      theme_timer:close()
      theme_timer = nil
    end

    -- Create a new timer
    theme_timer = vim.loop.new_timer()
    theme_timer:start(
      interval_ms,
      interval_ms,
      vim.schedule_wrap(function()
        manager.set_random_dark_theme()
      end)
    )
  end

  -- Function to stop the theme timer
  function manager.stop_theme_timer()
    if theme_timer then
      theme_timer:stop()
      theme_timer:close()
      theme_timer = nil
    end
  end

  return manager
end

return t
