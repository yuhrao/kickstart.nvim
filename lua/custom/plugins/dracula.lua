return {
  dir = vim.fn.stdpath 'config' .. '/lua/custom/local/dracula-pro',
  lazy = false,
  config = function()
    vim.opt.termguicolors = true
    vim.cmd [[colorscheme dracula_pro_buffy]]
    -- vim.cmd [[colorscheme dracula_pro_van_helsing]]
  end,
}

-- return {
--   dir = vim.fn.stdpath 'config' .. '/lua/custom/local/dracula-beta',
--   lazy = false,
--   config = function()
--     vim.opt.termguicolors = true
--     vim.cmd [[colorscheme dracula_pro_buffy]]
--   end,
-- }
