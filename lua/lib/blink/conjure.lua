local conjure_eval = require 'conjure.eval'
local conjure_client = require 'conjure.client'

local ConjureSource = {}

function ConjureSource.new(opts)
  opts = opts or {}

  return setmetatable({
    prefix_min_len = opts.prefix_min_len or 1,
    get_prefix = opts.get_prefix or function(context)
      -- By default, extract a word prefix from the line before the cursor
      return context.line:sub(1, context.cursor[2]):match '[%w_-]+$' or ''
    end,
  }, { __index = ConjureSource })
end

function ConjureSource:get_completions(context, resolve)
  -- If there's no current Conjure client (no REPL connected), return no completions
  if conjure_client.current() == nil then
    resolve()
    return
  end

  local prefix = self.get_prefix(context)

  -- If prefix is too short, no completions yet
  if #prefix < self.prefix_min_len then
    resolve()
    return
  end

  -- Asynchronously fetch completions from Conjure
  conjure_eval.completions(prefix, function(results)
    if not results or #results == 0 then
      resolve()
      return
    end

    local items = {}
    for _, completion in ipairs(results) do
      table.insert(items, {
        label = completion.word,
        detail = completion.menu,
        documentation = completion.info,
        kind = vim.lsp.protocol.CompletionItemKind.Text,
        insertText = completion.word,
      })
    end

    resolve {
      is_incomplete_forward = false,
      is_incomplete_backward = false,
      items = items,
    }
  end)
end

return ConjureSource
