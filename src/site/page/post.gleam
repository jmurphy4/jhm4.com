import gleam/result
import lustre/attribute
import lustre/element.{type Element}
import lustre/element/html
import mork
import mork/to_lustre
import simplifile
import site/layout
import site/post.{type Post}

pub fn view(post: Post) -> Element(Nil) {
  let body =
    simplifile.read(from: post.source)
    |> result.unwrap("I haven't written this note yet.")
    |> mork.parse
    |> to_lustre.to_lustre

  layout.view(
    post.title,
    "/blog/",
    "/blog/" <> post.slug <> "/",
    html.main([attribute.class("page post-page")], [
      html.article([], [
        html.header([attribute.class("post-header")], [
          html.a(
            [
              attribute.attribute("href", "/blog/"),
              attribute.class("back-link"),
            ],
            [html.text("← The logbook")],
          ),
          html.time([], [html.text(post.published)]),
          html.h1([], [html.text(post.title)]),
          html.p([attribute.class("post-description")], [
            html.text(post.description),
          ]),
        ]),
        html.div([attribute.class("prose post-body")], body),
      ]),
    ]),
  )
}
