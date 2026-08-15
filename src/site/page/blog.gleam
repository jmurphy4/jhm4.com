import gleam/list
import lustre/attribute
import lustre/element.{type Element}
import lustre/element/html
import site/layout
import site/post

pub fn view() -> Element(Nil) {
  let entries =
    post.all()
    |> list.map(fn(post) {
      html.article([attribute.class("post-card")], [
        html.time([], [html.text(post.published)]),
        html.h2([], [link("/blog/" <> post.slug <> "/", post.title)]),
        html.p([], [html.text(post.description)]),
        html.a(
          [
            attribute.attribute("href", "/blog/" <> post.slug <> "/"),
            attribute.class("read-link"),
          ],
          [html.text("Read note →")],
        ),
      ])
    })

  layout.view(
    "Blog",
    "/blog/",
    "/blog/",
    html.main([attribute.class("page blog-page")], [
      html.p([attribute.class("eyebrow")], [html.text("THE LOGBOOK")]),
      html.h1([], [html.text("Notes from along the way.")]),
      html.p([attribute.class("lede")], [
        html.text(
          "Occasional writing about software, projects, and whatever else stays on my mind.",
        ),
      ]),
      html.a(
        [attribute.attribute("href", "/atom.xml"), attribute.class("feed-link")],
        [html.text("Subscribe via Atom")],
      ),
      html.section([attribute.class("post-list")], entries),
    ]),
  )
}

fn link(path: String, label: String) -> Element(Nil) {
  html.a([attribute.attribute("href", path)], [html.text(label)])
}
