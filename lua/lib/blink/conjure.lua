local conjure_eval = require 'conjure.eval'
local conjure_client = require 'conjure.client'

local ConjureSource = {}

function ConjureSource.new(opts)
  opts = opts or {}
  
  -- Default filetype filter to only Clojure and ClojureScript files
  local filetype_filter = opts.filetype_filter or {
    include = { "clojure", "clojurescript" },
  }

  return setmetatable({
    prefix_min_len = opts.prefix_min_len or 2,
    filetype_filter = filetype_filter,
    get_prefix = opts.get_prefix or function(context)
      -- Extract a prefix from the line before the cursor
      -- This includes alphanumeric characters, underscores, hyphens, dots, and colons
      -- which are commonly used in Clojure symbols and namespaces
      return context.line:sub(1, context.cursor[2]):match '[%w_%.:-]+$' or ''
    end,
  }, { __index = ConjureSource })
end

-- Determine the appropriate completion kind based on the information from Conjure
local function determine_kind(completion)
  local kind = vim.lsp.protocol.CompletionItemKind
  
  -- Default to Function if we can't determine anything better
  if not completion.menu then
    return kind.Function
  end
  
  local menu_lower = string.lower(completion.menu)
  
  -- Try to determine the kind based on the menu text
  if string.find(menu_lower, "namespace") or string.find(menu_lower, "ns") then
    return kind.Module
  elseif string.find(menu_lower, "macro") then
    return kind.Snippet
  elseif string.find(menu_lower, "var") or string.find(menu_lower, "atom") or string.find(menu_lower, "ref") then
    return kind.Variable
  elseif string.find(menu_lower, "special") or string.find(menu_lower, "spec") then
    return kind.Keyword
  elseif string.find(menu_lower, "keyword") then
    return kind.Enum
  elseif string.find(menu_lower, "class") then
    return kind.Class
  elseif string.find(menu_lower, "protocol") or string.find(menu_lower, "interface") then
    return kind.Interface
  else
    -- Default to Function for anything else
    return kind.Function
  end
end

function ConjureSource:should_complete(context)
  -- Check if current buffer filetype is in the include list
  local current_ft = vim.api.nvim_buf_get_option(0, 'filetype')
  
  if self.filetype_filter and self.filetype_filter.include then
    for _, ft in ipairs(self.filetype_filter.include) do
      if current_ft == ft then
        return true
      end
    end
    return false
  end
  
  return true -- Default to true if no filter is specified
end

function ConjureSource:get_completions(context, resolve)
  -- Check if we should complete in the current buffer
  if not self:should_complete(context) then
    resolve()
    return
  end

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
        kind = determine_kind(completion),
        insertText = completion.word,
        -- Add sorting priority to push Clojure completions higher
        sortText = string.format("%03d%s", 100, completion.word),
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
