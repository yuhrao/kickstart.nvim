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