-- return {
--   dir = vim.fn.stdpath 'config' .. '/lua/custom/local/dracula-pro',
--   lazy = false,
--   config = function()
--     vim.opt.termguicolors = true
--     vim.cmd [[colorscheme dracula_pro_buffy]]
--     -- vim.cmd [[colorscheme dracula_pro_van_helsing]]
--   end,
-- }

return {
  dir = vim.fn.stdpath 'config' .. '/lua/custom/local/dracula-beta',
  lazy = false,
  config = function()
    vim.opt.termguicolors = true
    -- vim.cmd [[colorscheme dracula_pro_buffy]]

    local themes = {
      'dracula_pro',
      'dracula_pro_buffy',
      'dracula_pro_lincoln',
      'dracula_pro_morbius',
      'dracula_pro_blade',
      'dracula_pro_van_helsing',
    }

    local function set_random_theme()
      -- Seed the random number generator
      math.randomseed(os.time())

      local random_theme = themes[math.random(#themes)]

      vim.cmd('colorscheme ' .. random_theme)

      print('Theme set to: ' .. random_theme)
    end

    set_random_theme()

    -- Create a Neovim command to set a random theme
    vim.api.nvim_create_user_command('RandomTheme', set_random_theme, {})
    vim.api.nvim_create_user_command('TurnLightsOn', function()
      vim.cmd [[colorscheme alucard]]
    end, {})
  end,
}
