import { watch } from "node:fs"
import { resolve, sep } from "node:path"

const root = resolve(import.meta.dir, "..")
const output = resolve(root, "dist")
const clients = new Set()
let timer
let building = false
let queued = false

async function build() {
  if (building) {
    queued = true
    return
  }

  building = true
  const process = Bun.spawn(["gleam", "run", "-m", "build"], {
    cwd: root,
    stdout: "inherit",
    stderr: "inherit",
  })
  const exitCode = await process.exited
  building = false

  if (exitCode === 0) {
    for (const send of clients) send("data: reload\n\n")
  }

  if (queued) {
    queued = false
    await build()
  }
}

function scheduleBuild() {
  clearTimeout(timer)
  timer = setTimeout(build, 90)
}

for (const directory of ["src", "content", "public"]) {
  watch(resolve(root, directory), { recursive: true }, scheduleBuild)
}

await build()

const reloadScript = `
<script>
  new EventSource('/__reload').onmessage = () => location.reload()
</script>`

const server = Bun.serve({
  port: 4173,
  async fetch(request) {
    const url = new URL(request.url)

    if (url.pathname === "/__reload") {
      let send
      const stream = new ReadableStream({
        start(controller) {
          send = message => controller.enqueue(new TextEncoder().encode(message))
          clients.add(send)
        },
        cancel() {
          clients.delete(send)
        },
      })
      return new Response(stream, {
        headers: {
          "Content-Type": "text/event-stream",
          "Cache-Control": "no-cache",
          Connection: "keep-alive",
        },
      })
    }

    let pathname = decodeURIComponent(url.pathname)
    if (pathname.endsWith("/")) pathname += "index.html"
    const filePath = resolve(output, `.${pathname}`)
    if (filePath !== output && !filePath.startsWith(output + sep)) {
      return new Response("Not found", { status: 404 })
    }

    const file = Bun.file(filePath)
    if (!(await file.exists())) return new Response("Not found", { status: 404 })

    if (filePath.endsWith(".html")) {
      const html = (await file.text()).replace("</body>", `${reloadScript}</body>`)
      return new Response(html, {
        headers: {
          "Content-Type": "text/html; charset=utf-8",
          "Cache-Control": "no-store",
        },
      })
    }

    return new Response(file, { headers: { "Cache-Control": "no-store" } })
  },
})

console.log(`Development server: ${server.url}`)
console.log("Watching src/, content/, and public/ for changes")
