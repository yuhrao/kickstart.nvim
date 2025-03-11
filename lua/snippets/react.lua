local ls = require 'luasnip'
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local fmt = require('luasnip.extras.fmt').fmt
local rep = require('luasnip.extras').rep
local fmta = require('luasnip.extras.fmt').fmta

local react_snippets = {
  -- Functional component
  s(
    'rfc',
    fmt(
      [[ function {}({}) {{
  return (
    <div>
      {}
    </div>
  )
}}

export default {}
]],
      {
        i(1, 'ComponentName'),
        i(2, 'props'),
        i(3, '// component content'),
        rep(1),
      }
    )
  ),

  -- Arrow function component
  s(
    'rafc',
    fmt(
      [[
const {} = ({}) => {{
  return (
    <div>
      {}
    </div>
  )
}}

export default {}
]],
      {
        i(1, 'ComponentName'),
        i(2, 'props'),
        i(3, '// component content'),
        rep(1),
      }
    )
  ),

  -- Hook: useState
  s(
    'usestate',
    fmt('const [{}, set{}] = useState({})', {
      i(1, 'state'),
      f(function(args)
        return args[1][1]:gsub('^%l', string.upper)
      end, { 1 }),
      i(2, 'initialValue'),
    })
  ),

  -- Hook: useEffect
  s(
    'useeffect',
    fmt(
      [[
useEffect(() => {{
  {}

  {}
}}, [{}])]],
      {
        i(1, '// effect code'),
        i(2, '// cleanup function'),
        i(3, 'dependencies'),
      }
    )
  ),

  -- Hook: useEffect with cleanup
  s(
    'useeffectc',
    fmt(
      [[
useEffect(() => {{
  {}

  return () => {{
    {}
  }}
}}, [{}])]],
      {
        i(1, '// effect code'),
        i(2, '// cleanup code'),
        i(3, 'dependencies'),
      }
    )
  ),

  -- Hook: useRef
  s(
    'useref',
    fmt('const {} = useRef({})', {
      i(1, 'ref'),
      i(2, 'initialValue'),
    })
  ),

  -- Hook: useContext
  s(
    'usecontext',
    fmt('const {} = useContext({})', {
      i(1, 'value'),
      i(2, 'Context'),
    })
  ),

  -- Hook: useReducer
  s(
    'usereducer',
    fmt('const [{}, dispatch] = useReducer({}, {})', {
      i(1, 'state'),
      i(2, 'reducer'),
      i(3, 'initialState'),
    })
  ),

  -- Hook: useCallback
  s(
    'usecallback',
    fmt(
      [[
const {} = useCallback(({}) => {{
  {}
}}, [{}])]],
      {
        i(1, 'callback'),
        i(2, 'params'),
        i(3, '// callback body'),
        i(4, 'dependencies'),
      }
    )
  ),

  -- Hook: useMemo
  s(
    'usememo',
    fmt(
      [[
const {} = useMemo(() => {{
  {}
  return {}
}}, [{}])]],
      {
        i(1, 'memoizedValue'),
        i(2, '// computation'),
        i(3, 'result'),
        i(4, 'dependencies'),
      }
    )
  ),

  -- Fragment shorthand
  s(
    'frag',
    fmt('<>{}</>', {
      i(1, '// content'),
    })
  ),

  -- React.Fragment full syntax
  s(
    'fragment',
    fmt('<React.Fragment>{}</React.Fragment>', {
      i(1, '// content'),
    })
  ),

  -- JSX map
  s(
    'map',
    fmt('{{{}?.map(({}) => (\n  {}\n))}}', {
      i(1, 'items'),
      i(2, 'item'),
      i(3, '<div key={item.id}>{item.name}</div>'),
    })
  ),

  -- JSX conditional rendering with &&
  s(
    'ifr',
    fmt('{{{}? {} : null}}', {
      i(1, 'condition'),
      i(2, '<Component />'),
    })
  ),

  -- JSX conditional rendering with ternary
  s(
    'ternary',
    fmt('{{{} ? {} : {}}}', {
      i(1, 'condition'),
      i(2, '// render when true'),
      i(3, '// render when false'),
    })
  ),

  -- useState import snippet
  s('ims', fmt("import {{ useState }} from 'react'", {})),

  -- useEffect import snippet
  s('ime', fmt("import {{ useEffect }} from 'react'", {})),

  -- Multiple hooks import snippet
  s(
    'imr',
    fmt("import {{ {}, {} }} from 'react'", {
      i(1, 'useState'),
      i(2, 'useEffect'),
    })
  ),

  -- React.FC component
  s(
    'rcomp',
    fmt(
      [[
type {}Props = {{
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
]],
      {
        i(1, 'Component'),
        i(2, '// props'),
        rep(1),
        rep(1),
        i(3, '// destructured props'),
        i(4, '// component content'),
        rep(1),
      }
    )
  ),

  -- Context Provider
  s(
    'context',
    fmt(
      [[
import {{ createContext, useState, useContext }} from 'react'

type {}ContextType = {{
  {}
  {}?: ({}) => void
}}

const {}Context = createContext<{}ContextType | undefined>(undefined)

export const use{} = () => {{
  const context = useContext({}Context)
  if (!context) {{
    throw new Error('use{} must be used within a {}Provider')
  }}
  return context
}}

export const {}Provider = ({{ children }}: {{ children: React.ReactNode }}) => {{
  const [{}Value, set{}Value] = useState<{}>({}){};

  const {} = ({}) => {{
    set{}Value({})
  }}

  return (
    <{}Context.Provider value={{{{ {}, {} }}}}>
      {{children}}
    <{}Context.Provider>
  )
}}
]],
      {
        i(1, 'Feature'),
        i(2, 'value: string'),
        i(3, 'updateValue'),
        i(4, 'newValue: string'),
        rep(1),
        rep(1),
        rep(1),
        rep(1),
        rep(1),
        rep(1),
        rep(1),
        i(5, 'value'),
        f(function(args)
          return args[1][1]:gsub('^%l', string.upper)
        end, { 5 }),
        i(6, 'string'),
        i(7, "''"),
        i(8, '// additional state'),
        i(9, 'updateValue'),
        i(10, 'newValue'),
        rep(5),
        i(11, '// update logic'),
        rep(5),
        rep(1),
        rep(5),
        rep(9),
        rep(1),
      }
    )
  ),

  -- Custom hook
  s(
    'hook',
    fmt(
      [[
import {{ useState, useEffect }} from 'react'

export function use{}({}) {{
  const [value, setValue] = useState({})
  
  useEffect(() => {{
    {}
    
    return () => {{
      {}
    }}
  }}, [{}])
  
  return {}
}}
]],
      {
        i(1, 'HookName'),
        i(2, 'dependency'),
        i(3, 'initialValue'),
        i(4, '// effect logic'),
        i(5, '// cleanup'),
        i(6, 'dependency'),
        i(7, 'value'),
      }
    )
  ),

  -- Error boundary
  s(
    'errb',
    fmt(
      [[
import {{ Component, ErrorInfo, ReactNode }} from 'react'

interface ErrorBoundaryProps {{
  children: ReactNode
  fallback?: ReactNode
}}

interface ErrorBoundaryState {{
  hasError: boolean
  error?: Error
}}

class ErrorBoundary extends Component<ErrorBoundaryProps, ErrorBoundaryState> {{
  constructor(props: ErrorBoundaryProps) {{
    super(props)
    this.state = {{ hasError: false }}
  }}

  static getDerivedStateFromError(error: Error) {{
    return {{ hasError: true, error }}
  }}

  componentDidCatch(error: Error, errorInfo: ErrorInfo) {{
    console.error("Error caught by ErrorBoundary:", error, errorInfo)
  }}

  render() {{
    if (this.state.hasError) {{
      return this.props.fallback || <div>Something went wrong.</div>
    }}

    return this.props.children
  }}
}}

export default ErrorBoundary
]],
      {}
    )
  ),

  -- Component with event handlers
  s(
    'eventcomp',
    fmt(
      [[
import {{ useState }} from 'react'

interface {}Props {{
  onSubmit?: (data: {}) => void
}}

export const {} = ({{ onSubmit }}: {}Props) => {{
  const [value, setValue] = useState('')

  const handleChange = (e: React.ChangeEvent<HTMLInputElement>) => {{
    setValue(e.target.value)
  }}

  const handleSubmit = (e: React.FormEvent) => {{
    e.preventDefault()
    onSubmit?.({{ value }})
  }}

  return (
    <form onSubmit={{handleSubmit}}>
      <input 
        type="text"
        value={{value}}
        onChange={{handleChange}}
        placeholder="{}"
      />
      <button type="submit">{}</button>
    </form>
  )
}}
]],
      {
        i(1, 'Component'),
        i(2, '{ value: string }'),
        rep(1),
        rep(1),
        i(3, 'Enter value...'),
        i(4, 'Submit'),
      }
    )
  ),
}

ls.add_snippets('javascriptreact', react_snippets)
ls.add_snippets('typescriptreact', react_snippets)

-- Additional TSX-specific snippets
ls.add_snippets('typescriptreact', {
  -- Typed component props
  s(
    'props',
    fmt(
      [[
interface {}Props {{
  {}
}}
]],
      {
        i(1, 'Component'),
        i(2, 'propName: type'),
      }
    )
  ),

  -- React.memo with types
  s(
    'memo',
    fmt(
      [[
import {{ memo }} from 'react'

interface {}Props {{
  {}
}}

const {} = memo<{}Props>(({{ {} }}) => {{
  return (
    <div>
      {}
    </div>
  )
}})

export default {}
]],
      {
        i(1, 'Component'),
        i(2, 'propName: type'),
        rep(1),
        rep(1),
        i(3, 'propName'),
        i(4, '// component content'),
        rep(1),
      }
    )
  ),

  -- TypeScript event handler
  s(
    'onchange',
    fmt('const handle{} = (e: React.{}<{}>) => {{\n  {}\n}}', {
      i(1, 'Change'),
      c(2, {
        t 'ChangeEvent',
        t 'FormEvent',
        t 'MouseEvent',
        t 'KeyboardEvent',
      }),
      c(3, {
        t 'HTMLInputElement',
        t 'HTMLFormElement',
        t 'HTMLButtonElement',
        t 'HTMLDivElement',
        t 'HTMLElement',
      }),
      i(4, '// event handler logic'),
    })
  ),
})

return {}

