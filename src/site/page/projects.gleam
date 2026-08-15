import lustre/attribute
import lustre/element.{type Element}
import lustre/element/html
import site/layout

pub fn view() -> Element(Nil) {
  layout.view(
    "Projects",
    "/projects/",
    "/projects/",
    html.main([attribute.class("page collection-page")], [
      html.p([attribute.class("eyebrow")], [html.text("PROJECTS")]),
      html.h1([], [html.text("Things I've made.")]),
      html.p([attribute.class("lede")], [
        html.text(
          "A growing collection of software, experiments, and ideas that made it off the drawing board.",
        ),
      ]),
      html.section([attribute.class("project-list")], [
        html.article([attribute.class("project-card")], [
          html.p([attribute.class("project-kind")], [
            html.text("PERSONAL WEBSITE"),
          ]),
          html.h2([], [
            html.a([attribute.attribute("href", "/")], [
              html.text("jhm4.com"),
            ]),
          ]),
          html.p([], [
            html.text(
              "A personal site and logbook built in Gleam with Lustre, generated as static HTML, and deployed through GitHub Pages.",
            ),
          ]),
          html.ul([attribute.class("tag-list")], [
            html.li([], [html.text("Gleam")]),
            html.li([], [html.text("Lustre")]),
            html.li([], [html.text("GitHub Pages")]),
          ]),
        ]),
        html.article([attribute.class("project-card project-placeholder")], [
          html.p([attribute.class("project-kind")], [html.text("NEXT UP")]),
          html.h2([], [html.text("More from the workshop")]),
          html.p([], [
            html.text(
              "More projects will appear here as they become ready to share.",
            ),
          ]),
        ]),
      ]),
    ]),
  )
}
