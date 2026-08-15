import lustre/attribute
import lustre/element.{type Element}
import lustre/element/html
import site/layout

pub fn view() -> Element(Nil) {
  layout.view(
    "Home",
    "/",
    "/",
    html.main([attribute.class("page home-page")], [
      html.section([attribute.class("intro")], [
        html.p([attribute.class("eyebrow")], [html.text("HELLO, I'M MURPHY")]),
        html.h1([], [
          html.text("I make things for people, "),
          html.em([], [html.text("and sometimes just for fun.")]),
        ]),
        html.p([attribute.class("lede")], [
          html.text(
            "This is my small corner of the internet: a place for projects, notes, and ideas worth revisting.",
          ),
        ]),
        html.div([attribute.class("home-links")], [
          link("/about/", "A little about me"),
          link("/blog/", "Read the logbook"),
        ]),
      ]),
    ]),
  )
}

fn link(path: String, label: String) -> Element(Nil) {
  html.a([attribute.attribute("href", path)], [html.text(label)])
}
