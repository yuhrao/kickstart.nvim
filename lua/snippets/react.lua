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
  -- React Server Component (RSC)
  s(
    'rsc',
    fmt(
      [[
// This is a React Server Component
export default async function {}({}) {{
  // Server-side data fetching
  {}

  return (
    <div>
      {}
    </div>
  )
}}
]],
      {
        i(1, 'ServerComponent'),
        i(2, 'props'),
        i(3, '// Fetch your data directly in the component'),
        i(4, '// Render with server data'),
      }
    )
  ),

  -- useFormStatus hook for form validation (React 18+)
  s(
    'formstatus',
    fmt(
      [[
'use client'

import {{ useFormStatus }} from 'react-dom'

function SubmitButton() {{
  const {{ pending }} = useFormStatus()
  
  return (
    <button type="submit" disabled={{pending}}>
      {{pending ? '{}'  : '{}'}}
    </button>
  )
}}
]],
      {
        i(1, 'Submitting...'),
        i(2, 'Submit'),
      }
    )
  ),

  -- React useFormState for form management
  s(
    'formstate',
    fmt(
      [[
'use client'

import {{ useFormState }} from 'react-dom'
import {{ useRef }} from 'react'

// Server action
{}

function {}() {{
  const [state, formAction] = useFormState({}, null)
  const formRef = useRef<HTMLFormElement>(null)
  
  return (
    <form ref={{formRef}} action={{formAction}}>
      {{state?.error && <p className="error">{{state.error}}</p>}}
      {}
      <button type="submit">{}</button>
    </form>
  )
}}
]],
      {
        i(1, "async function handleSubmit(prevState: any, formData: FormData) {\n  'use server'\n  // Process the form data\n  const value = formData.get('value')\n  \n  // Validate and return state\n  if (!value) return { error: 'Value is required' }\n  \n  // Process data...\n  return { success: true }\n}"),
        i(2, 'FormComponent'),
        i(3, '// Form inputs'),
        i(4, 'Submit'),
      }
    )
  ),
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

  -- Hook: useDeferredValue (React 18+)
  s(
    'usedeferred',
    fmt(
      [[
const {} = useDeferredValue({})
]],
      {
        i(1, 'deferredValue'),
        i(2, 'value')
      }
    )
  ),

  -- Hook: useTransition (React 18+)
  s(
    'usetrans',
    fmt(
      [[
const [isPending, startTransition] = useTransition()

const handle{} = () => {{
  startTransition(() => {{
    {}
  }})
}}
]],
      {
        i(1, 'Click'),
        i(2, '// state update')
      }
    )
  ),

  -- React.lazy with Suspense (modern code splitting)
  s(
    'lazy',
    fmt(
      [[
import {{ lazy, Suspense }} from 'react'

const {} = lazy(() => import('{}'))

// Usage with Suspense:
// <Suspense fallback={<div>Loading...</div>}>
//   <{} />
// </Suspense>
]],
      {
        i(1, 'Component'),
        i(2, './components/Component'),
        rep(1)
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

  -- Modern Error Boundary using React 18's useErrorBoundary
  s(
    'errb',
    fmt(
      [[
import {{ useState, useCallback, useContext, createContext, ReactNode }} from 'react'

interface ErrorBoundaryProps {{
  children: ReactNode
  fallback: React.ComponentType<{{ error: Error; reset: () => void }}>
}}

export default function ErrorBoundary({{ children, fallback: Fallback }}: ErrorBoundaryProps) {{
  const [error, setError] = useState<Error | null>(null)
  
  const reset = useCallback(() => {{
    setError(null)
  }}, [])
  
  const handleError = useCallback((error: Error) => {{
    console.error("Error caught by ErrorBoundary:", error)
    setError(error)
  }}, [])
  
  if (error) {{
    return <Fallback error={{error}} reset={{reset}} />
  }}
  
  return (
    <ErrorBoundaryContext.Provider value={{handleError}}>
      {{children}}
    </ErrorBoundaryContext.Provider>
  )
}}

// Create context for error handling
const ErrorBoundaryContext = 
  createContext<(error: Error) => void>(() => {{}})

// Hook to consume the error boundary context
export function useErrorBoundary() {{
  return useContext(ErrorBoundaryContext)
}}

// Example usage:
// <ErrorBoundary fallback={{({error, reset}) => (
//   <div>
//     <p>Something went wrong: {{error.message}}</p>
//     <button onClick={{reset}}>Try again</button>
//   </div>
// )}}>
//   <YourComponent />
// </ErrorBoundary>
]],
      {}
    )
  ),

  -- Simple Error Fallback Component  
  s(
    'errfallback',
    fmt(
      [[
function ErrorFallback({{ error, reset }}: {{ error: Error; reset: () => void }}) {{
  return (
    <div role="alert" className="error-boundary">
      <h2>Something went wrong</h2>
      <pre>{{error.message}}</pre>
      <button onClick={{reset}}>Try again</button>
    </div>
  )
}}
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

-- Add snippets to various filetypes
ls.add_snippets('javascriptreact', react_snippets)
ls.add_snippets('typescriptreact', react_snippets)

-- React Server Component filetypes (for Next.js App Router)
ls.add_snippets('typescript', {
  s(
    'useserver',
    fmt(
      [[
'use server'

export async function {}({}): Promise<{}> {{
  {}
  
  return {}
}}
]],
      {
        i(1, 'serverAction'),
        i(2, 'formData: FormData'),
        i(3, '{ success: boolean, error?: string }'),
        i(4, '// Server-side logic'),
        i(5, '{ success: true }'),
      }
    )
  ),
})

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
  
  -- useId hook for accessibility (React 18+)
  s(
    'useid',
    fmt(
      [[
const {} = useId()
// Usage: id={{{}}}, aria-labelledby={{{}}}-label, etc.
]],
      {
        i(1, 'id'),
        rep(1),
        rep(1),
      }
    )
  ),
  
  -- useSyncExternalStore hook (React 18+)
  s(
    'usesync',
    fmt(
      [[
import {{ useSyncExternalStore }} from 'react'

function use{}() {{
  const {} = useSyncExternalStore(
    {}.subscribe,
    {}.getSnapshot,
    {}.getServerSnapshot
  )
  
  return {}
}}
]],
      {
        i(1, 'ExternalStore'),
        i(2, 'value'),
        i(3, 'externalStore'),
        rep(3),
        rep(3),
        rep(2),
      }
    )
  ),

  -- React.use hook for promises in components (React 18+)
  s(
    'reactuse',
    fmt(
      [[
// For use inside components with promises from parent
const data = use({})
]],
      {
        i(1, 'somePromise'),
      }
    )
  ),
}

return {}

