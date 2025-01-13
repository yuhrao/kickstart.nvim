local clj = {}

local function EvalToClipboard()
  local extract = require 'conjure.extract'
  local eval = require 'conjure.eval'

  -- Extract the current form under the cursor
  local form = extract.form { ['root?'] = false }
  if form then
    eval['eval-str'] {
      code = form.content,
      origin = 'custom-clipboard-eval',
      -- Handle the evaluation result
      ['on-result'] = function(result)
        -- Extract the value from the result

        -- Copy the result to the clipboard
        vim.fn.setreg('+', result)
        print 'Result copied to clipboard'
      end,
    }
  else
    print 'No form found to evaluate.'
  end
end

clj.config = function()
  require('conjure.main').main()
  require('conjure.mapping')['on-filetype']()
  local client = require 'conjure.client'

  vim.keymap.set('n', '<localleader>eE', EvalToClipboard, { desc = 'Eval form to clipboard' })
  vim.keymap.set('n', "<localleader>'", '<Cmd>ConjureConnect<CR>', { desc = 'Conjure Connect' })
end

clj.setup_baleia = function()
  vim.g.baleia = require('baleia').setup { line_starts_at = 3 }

  -- Command to colorize the current buffer
  vim.api.nvim_create_user_command('BaleiaColorize', function()
    vim.g.baleia.once(vim.api.nvim_get_current_buf())
  end, { bang = true })

  -- Command to show logs
  vim.api.nvim_create_user_command('BaleiaLogs', vim.g.baleia.logger.show, { bang = true })
end

clj.enable_colorizer = function()
  -- Print color codes if baleia.nvim is available
  local colorize = require 'baleia.nvim'
  vim.g['conjure#log#strip_ansi_escape_sequences_line_limit'] = colorize and 1 or nil

  -- Disable diagnostics in log buffer and colorize it
  vim.api.nvim_create_autocmd('BufWinEnter', {
    pattern = 'conjure-log-*',
    callback = function(event)
      vim.g.baleia.automatically(event.buf)
    end,
  })
end

clj.keymaps = function()
  vim.g['conjure#client#clojure#nrepl#mapping#session_fresh'] = 'rf'
  vim.g['conjure#client#clojure#nrepl#mapping#run_current_test'] = 'te'
  vim.g['conjure#mapping#eval_visual'] = 'e'
end

clj.init = function()
  clj.enable_colorizer()

  vim.g['conjure#debug'] = false
  vim.g['conjure#client_on_load'] = false
  vim.g['conjure#mapping#doc_word'] = false
  vim.g['conjure#extract#tree_sitter#enabled'] = true
  vim.g['conjure#client#clojure#nrepl#eval#raw_out'] = true
  vim.g['conjure#client#clojure#nrepl#test#raw_out'] = true
  vim.g['conjure#client#clojure#nrepl#test#current_form_names'] = { 'deftest', 'defflow' }
  vim.g['conjure#highlight#enabled'] = true
  vim.g['conjure#client#clojure#nrepl#completion#with_context'] = true -- Testing it out put false if something breaks

  clj.keymaps()
end

return clj
