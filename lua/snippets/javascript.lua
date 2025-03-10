local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local fmt = require("luasnip.extras.fmt").fmt
local rep = require("luasnip.extras").rep

ls.add_snippets("javascript", {
  -- Function
  s("fn", fmt("function {}({}) {{\n  {}\n}}", {
    i(1, "name"),
    i(2, "params"),
    i(3, "// TODO"),
  })),

  -- Arrow Function
  s("afn", fmt("const {} = ({}) => {{\n  {}\n}}", {
    i(1, "name"),
    i(2, "params"),
    i(3, "// TODO"),
  })),

  -- Inline Arrow Function
  s("iafn", fmt("const {} = ({}) => {}", {
    i(1, "name"),
    i(2, "params"),
    i(3, "expression"),
  })),

  -- Console log
  s("cl", fmt("console.log({})", {
    i(1, "message"),
  })),

  -- Console log with label
  s("cll", fmt("console.log('{}:', {})", {
    i(1, "label"),
    i(2, "variable"),
  })),

  -- If statement
  s("if", fmt("if ({}) {{\n  {}\n}}", {
    i(1, "condition"),
    i(2, "// TODO"),
  })),

  -- If/else statement
  s("ife", fmt("if ({}) {{\n  {}\n}} else {{\n  {}\n}}", {
    i(1, "condition"),
    i(2, "// TODO"),
    i(3, "// TODO"),
  })),

  -- Try/catch
  s("try", fmt("try {{\n  {}\n}} catch ({}) {{\n  {}\n}}", {
    i(1, "// TODO"),
    i(2, "error"),
    i(3, "console.error(error)"),
  })),

  -- Import statement
  s("imp", fmt("import {} from '{}'", {
    i(1, "{ Component }"),
    i(2, "module"),
  })),

  -- Export default
  s("exd", fmt("export default {}", {
    i(1, "Component"),
  })),

  -- React component
  s("rfc", fmt([[
import React from 'react'

function {}({}) {{
  return (
    <div>
      {}
    </div>
  )
}}

export default {}
]], {
    i(1, "ComponentName"),
    i(2, "props"),
    i(3, "// TODO"),
    rep(1),
  })),
})

-- Also add these snippets to javascriptreact
ls.filetype_extend("javascriptreact", { "javascript" })