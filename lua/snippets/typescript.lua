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

ls.add_snippets("typescript", {
  -- TypeScript specific snippets
  
  -- Interface
  s("int", fmt("interface {} {{\n  {}\n}}", {
    i(1, "Name"),
    i(2, "property: type"),
  })),
  
  -- Type
  s("type", fmt("type {} = {}", {
    i(1, "Name"),
    i(2, "{}"),
  })),
  
  -- Enum
  s("enum", fmt("enum {} {{\n  {} = '{}',\n}}", {
    i(1, "Name"),
    i(2, "PROPERTY"),
    i(3, "value"),
  })),
  
  -- Function with types
  s("fn", fmt("function {}({}): {} {{\n  {}\n}}", {
    i(1, "name"),
    i(2, "param: type"),
    i(3, "ReturnType"),
    i(4, "// TODO"),
  })),
  
  -- Arrow Function with types
  s("afn", fmt("const {}: {} = ({}) => {{\n  {}\n}}", {
    i(1, "name"),
    i(2, "ReturnType"),
    i(3, "param: type"),
    i(4, "// TODO"),
  })),
  
  -- Class
  s("cls", fmt([[
class {} {{\n  constructor({}) {{\n    {}\n  }}\n  \n  {}(): {} {{\n    {}\n  }}
}}
]], {
    i(1, "Name"),
    i(2, "params"),
    i(3, "// Initialize"),
    i(4, "method"),
    i(5, "ReturnType"),
    i(6, "// TODO"),
  })),
  
  -- React FC with TypeScript
  s("rfc", fmt([[
import React from 'react'

interface {}Props {{
  {}
}}

const {}: React.FC<{}Props> = ({{{}}}) => {{
  return (
    <div>
      {}
    </div>
  )
}}

export default {}
]], {
    i(1, "Component"),
    i(2, "// props"),
    rep(1),
    rep(1),
    i(3, "destructured, props"),
    i(4, "// TODO"),
    rep(1),
  })),
  
  -- React FC with TypeScript using function declaration
  s("rfcf", fmt([[
import React from 'react'

interface {}Props {{
  {}
}}

function {}({}: {}Props): React.ReactElement {{
  return (
    <div>
      {}
    </div>
  )
}}

export default {}
]], {
    i(1, "Component"),
    i(2, "// props"),
    rep(1),
    i(3, "props"),
    rep(1),
    i(4, "// TODO"),
    rep(1),
  })),
  
  -- Generic declaration
  s("gen", fmt("<{}>", {
    i(1, "T"),
  })),
  
  -- Promise type
  s("prom", fmt("Promise<{}>", {
    i(1, "T"),
  })),
  
  -- Async function
  s("asf", fmt("async function {}({}): Promise<{}> {{\n  {}\n}}", {
    i(1, "name"),
    i(2, "params"),
    i(3, "ReturnType"),
    i(4, "// TODO"),
  })),
  
  -- Async arrow function
  s("aaf", fmt("const {} = async ({}): Promise<{}> => {{\n  {}\n}}", {
    i(1, "name"),
    i(2, "params"),
    i(3, "ReturnType"),
    i(4, "// TODO"),
  })),
})

-- Extend to TSX files
ls.filetype_extend("typescriptreact", { "typescript" })

-- Also include JavaScript snippets for TypeScript
ls.filetype_extend("typescript", { "javascript" })
ls.filetype_extend("typescriptreact", { "javascriptreact" })