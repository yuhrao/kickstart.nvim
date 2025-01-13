return {

  { -- Linting
    'mfussenegger/nvim-lint',
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
      local lint = require 'lint'

      lint.linters.markdownlint = {
        name = 'markdownlint',
        cmd = 'markdownlint',
        stdin = true,
        args = { '--stdin', '--disable', 'MD025', 'MD041', 'MD031', 'MD032', 'MD022' },
        ignore_exitcode = true,
        stream = 'stderr',
        parser = require('lint.parser').from_errorformat('stdin:%l:%c %m,stdin:%l %m', {
          source = 'markdownlint',
          severity = vim.diagnostic.severity.WARN,
        }),
      }

      lint.linters_by_ft = {
        markdown = { 'markdownlint' },
        javascript = { 'eslint_d' },
        javascriptreact = { 'eslint_d' },
        typescript = { 'eslint_d' },
        typescriptreact = { 'eslint_d' },
        svelte = { 'eslint_d' },
        clojure = { 'clj-kondo' },
        dockerfile = { 'hadolint' },
        json = { 'jsonlint' },
      }

      local lint_augroup = vim.api.nvim_create_augroup('lint', { clear = true })
      vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave' }, {
        group = lint_augroup,
        callback = function()
          -- Only run the linter in buffers that you can modify in order to
          -- avoid superfluous noise, notably within the handy LSP pop-ups that
          -- describe the hovered symbol using Markdown.
          if vim.opt_local.modifiable:get() then
            lint.try_lint()
          end
        end,
      })
    end,
  },
}
