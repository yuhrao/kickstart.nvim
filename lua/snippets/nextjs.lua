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

-- These snippets are shared for both JS and TS
local nextjs_snippets = {
  -- Next.js App Directory - Client Component
  s("nclient", fmt([[
'use client'

{}

export default function {}({}) {{
  return (
    <div>
      {}
    </div>
  )
}}
]], {
    i(1, "import { useState } from 'react'"),
    i(2, "Component"),
    i(3, "props"),
    i(4, "// component content"),
  })),

  -- Next.js App Directory - Server Component
  s("nserver", fmt([[
{}

export default async function {}({}) {{
  {}

  return (
    <div>
      {}
    </div>
  )
}}
]], {
    i(1, "// server-side imports"),
    i(2, "Component"),
    i(3, "props"),
    i(4, "// server-side data fetching"),
    i(5, "// component content"),
  })),

  -- Next.js Data Fetching in Server Component
  s("nfetch", fmt([[
// Data Fetching in Server Component
async function getData() {{
  {}
  
  // Using fetch with next.js cache settings
  const res = await fetch('{}', {{ 
    next: {{ 
      revalidate: {} // false | 0 | number in seconds
    }} 
  }})
  
  if (!res.ok) {{
    throw new Error('Failed to fetch data')
  }}
  
  return res.json()
}}

export default async function {}() {{
  const data = await getData()
  
  return (
    <>
      {}
    </>
  )
}}
]], {
    i(1, "// fetch configuration"),
    i(2, "https://api.example.com/data"),
    i(3, "60"),
    i(4, "Component"),
    i(5, "// render with data"),
  })),

  -- Next.js Route Handlers (API)
  s("nroute", fmt([[
// app/api/{}route.js
export async function GET(request: Request) {{
  const {{ searchParams }} = new URL(request.url)
  const id = searchParams.get('id')
  
  {}
  
  return Response.json({{ {} }})
}}

export async function POST(request: Request) {{
  const data = await request.json()
  
  {}
  
  return new Response(JSON.stringify({{ success: true }}), {{
    headers: {{ 'Content-Type': 'application/json' }}
  }})
}}
]], {
    i(1, "example/"),
    i(2, "// handle GET logic"),
    i(3, "data: 'value'"),
    i(4, "// handle POST logic"),
  })),

  -- Next.js Metadata for App Router
  s("nmeta", fmt([[
export const metadata = {{
  title: '{}',
  description: '{}',
  openGraph: {{
    title: '{}',
    description: '{}',
    images: ['{}'],
  }},
}}
]], {
    i(1, "Page Title"),
    i(2, "Page description"),
    rep(1),
    rep(2),
    i(3, "/images/og-image.jpg"),
  })),

  -- Next.js Dynamic Metadata
  s("nmetagen", fmt([[
export async function generateMetadata({{ params, searchParams }}: {{
  params: {{ {} }},
  searchParams: {{ [key: string]: string | string[] | undefined }}
}}) {{
  const id = params.{}
  
  // Fetch data
  const product = await fetch('{}').then((res) => res.json())
  
  return {{
    title: product.title,
    description: product.description,
  }}
}}
]], {
    i(1, "id: string"),
    i(2, "id"),
    i(3, `https://api.example.com/product/$\{id\}`),
  })),

  -- Next.js Loading State (App Router)
  s("nloading", fmt([[
// app/{}/loading.tsx
export default function Loading() {{
  return (
    <div className="loading-container">
      {}
    </div>
  )
}}
]], {
    i(1, "[slug]"),
    i(2, "// loading UI"),
  })),

  -- Next.js Error Handling (App Router)
  s("nerror", fmt([[
'use client'

import {{ useEffect }} from 'react'

export default function Error({{
  error,
  reset,
}}: {{
  error: Error & {{ digest?: string }},
  reset: () => void,
}}) {{
  useEffect(() => {{
    // Log the error to an error reporting service
    console.error(error)
  }}, [error])

  return (
    <div className="error-container">
      <h2>Something went wrong!</h2>
      <button
        onClick={() => reset()}
      >
        Try again
      </button>
    </div>
  )
}}
]], {}))),
  -- Next.js Page Component
  s("npage", fmt([[
import type {{ NextPage }} from 'next'
import Head from 'next/head'

const {}: NextPage = () => {{
  return (
    <div>
      <Head>
        <title>{}</title>
        <meta name="description" content="{}" />
        <link rel="icon" href="/favicon.ico" />
      </Head>

      <main>
        {}
      </main>
    </div>
  )
}}

export default {}
]], {
    i(1, "PageName"),
    i(2, "Page Title"),
    i(3, "Page description"),
    i(4, "// page content"),
    rep(1),
  })),

  -- Next.js API Route
  s("napi", fmt([[
import type {{ NextApiRequest, NextApiResponse }} from 'next'

type ResponseData = {{
  {}
}}

export default function handler(
  req: NextApiRequest,
  res: NextApiResponse<ResponseData>
) {{
  const {{ method }} = req

  switch (method) {{
    case 'GET':
      {}
      break
    case 'POST':
      {}
      break
    default:
      res.setHeader('Allow', ['GET', 'POST'])
      res.status(405).end(`Method ${{method}} Not Allowed`)
  }}
}}
]], {
    i(1, "message: string"),
    i(2, "// Handle GET request"),
    i(3, "// Handle POST request"),
  })),

  -- Next.js GetServerSideProps
  s("ngss", fmt([[
export async function getServerSideProps(context) {{
  {}

  return {{
    props: {{
      {}
    }},
  }}
}}
]], {
    i(1, "// Fetch data on the server"),
    i(2, "// props for your component"),
  })),

  -- Next.js GetStaticProps
  s("ngsp", fmt([[
export async function getStaticProps(context) {{
  {}

  return {{
    props: {{
      {}
    }},
    revalidate: {},
  }}
}}
]], {
    i(1, "// Fetch data at build time"),
    i(2, "// props for your component"),
    i(3, "10"),
  })),

  -- Next.js GetStaticPaths
  s("ngspa", fmt([[
export async function getStaticPaths() {{
  {}

  return {{
    paths: [
      {}
    ],
    fallback: {},
  }}
}}
]], {
    i(1, "// Fetch dynamic routes"),
    i(2, '{ params: { id: "1" } }'),
    c(3, {
      t("false"),
      t("true"),
      t("'blocking'"),
    }),
  })),

  -- Next.js Link
  s("nlink", fmt("<Link href={{{}}}>{}</Link>", {
    i(1, '"/route"'),
    i(2, "Link Text"),
  })),

  -- Next.js Image
  s("nimg", fmt([[
<Image
  src={{{}}}
  alt={{{}}}
  width={{{}}}
  height={{{}}}
  {}
/>
]], {
    i(1, '"/path/to/image.jpg"'),
    i(2, "Image description"),
    i(3, "500"),
    i(4, "300"),
    i(5, "priority"),
  })),

  -- Next.js Router
  s("nrouter", fmt("const router = useRouter(){}", {
    i(1, ""),
  })),

  -- Next.js useRouter Hook
  s("nuserouter", fmt([[
import {{ useRouter }} from 'next/router'

const {} = () => {{
  const router = useRouter()
  const {{ {} }} = router.query

  return (
    <div>
      {}
    </div>
  )
}}
]], {
    i(1, "Component"),
    i(2, "id"),
    i(3, "// component content"),
  })),

  -- Next.js _app.tsx
  s("napp", fmt([[
import type {{ AppProps }} from 'next/app'
import {}

function MyApp({{ Component, pageProps }}: AppProps) {{
  return (
    <>
      {}
      <Component {{...pageProps}} />
    </>
  )
}}

export default MyApp
]], {
    i(1, "'../styles/globals.css'"),
    i(2, "// global components like layouts, providers, etc."),
  })),

  -- Next.js _document.tsx
  s("ndoc", fmt([[
import Document, {{ Html, Head, Main, NextScript }} from 'next/document'

class MyDocument extends Document {{
  render() {{
    return (
      <Html lang="{}">
        <Head>
          {}
        </Head>
        <body>
          {}
          <Main />
          <NextScript />
        </body>
      </Html>
    )
  }}
}}

export default MyDocument
]], {
    i(1, "en"),
    i(2, "// custom head elements"),
    i(3, "// custom body elements"),
  })),

  -- Next.js Middleware
  s("nmid", fmt([[
import {{ NextResponse }} from 'next/server'
import type {{ NextRequest }} from 'next/server'

export function middleware(request: NextRequest) {{
  {}
  
  return NextResponse.next()
}}

export const config = {{
  matcher: [{}],
}}
]], {
    i(1, "// middleware logic"),
    i(2, "'/about/:path*', '/dashboard/:path*'"),
  })),

  -- Next.js Environment Variables
  s("nenv", fmt([[
// Environment variables
const {} = process.env.{} || {}
]], {
    i(1, "API_URL"),
    rep(1),
    i(2, "'default_value'"),
  })),

  -- Next.js Layout Component
  s("nlayout", fmt([[
import Head from 'next/head'

interface {}Props {{
  children: React.ReactNode
  title?: string
}}

export const {} = ({{ children, title = '{}' }}: {}Props) => {{
  return (
    <>
      <Head>
        <title>{{title}}</title>
        <meta name="description" content="{}" />
        <meta name="viewport" content="width=device-width, initial-scale=1" />
        <link rel="icon" href="/favicon.ico" />
      </Head>
      <header>
        {}
      </header>
      <main>
        {{children}}
      </main>
      <footer>
        {}
      </footer>
    </>
  )
}}
]], {
    i(1, "Layout"),
    rep(1),
    i(2, "Default Title"),
    rep(1),
    i(3, "Site description"),
    i(4, "// header content"),
    i(5, "// footer content"),
  })),

  -- Next.js Fetch with SWR
  s("nswr", fmt([[
import useSWR from 'swr'

const fetcher = (url: string) => fetch(url).then((res) => res.json())

export function use{}() {{
  const {{ data, error, isLoading, mutate }} = useSWR({}, fetcher)

  return {{
    data,
    isLoading,
    isError: error,
    mutate,
  }}
}}
]], {
    i(1, "Data"),
    i(2, "'/api/route'"),
  })),
}

-- Add these snippets to both JavaScript and TypeScript React files
ls.add_snippets("javascriptreact", nextjs_snippets)
ls.add_snippets("typescriptreact", nextjs_snippets)

return {}