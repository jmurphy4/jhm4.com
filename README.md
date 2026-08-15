# jhm4.com

John Murphy's personal site, built with [Gleam](https://gleam.run),
[Lustre](https://lustre.build), and Markdown.

## Local development

Install Gleam, download the Hex dependencies, and build the static site:

```sh
gleam deps download
gleam run -m build
```

The generated site is written to `dist/`. Serve that directory with any static
file server to preview it locally.

For development with automatic rebuilding and browser reloads, run:

```sh
bun scripts/dev.js
```

The development site is available at `http://localhost:4173` and watches
`src/`, `content/`, and `public/`.

## Writing a post

Add the Markdown file under `content/blog/`, then add its title, description,
date, slug, and source path to `all()` in `src/site/post.gleam`. The next build
will generate both the post page and its entry in the logbook.

Pushes to `master` are built and deployed to GitHub Pages automatically.
