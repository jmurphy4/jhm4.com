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
      html.section(
        [attribute.attribute("id", "about"), attribute.class("home-intro")],
        [
          html.div([attribute.class("intro-copy")], [
            html.p([attribute.class("eyebrow")], [
              html.text("HELLO, I'M MURPHY"),
            ]),
            html.h1([], [
              html.text("I make things for people, "),
              html.em([], [html.text("and sometimes just for fun.")]),
            ]),
            html.p([attribute.class("lede")], [
              html.text(
                "I'm a software builder based in Richmond, Virginia. I studied computer science at Georgia Tech, with stops in Washington D.C. and Florida along the way.",
              ),
            ]),
            html.p([attribute.class("personal-note")], [
              html.text(
                "Away from a keyboard, you'll usually find me with good friends, riding horses, working on a project, or sailing my ",
              ),
              html.a(
                [
                  attribute.attribute(
                    "href",
                    "https://sailboatdata.com/sailboat/harpoon-52/",
                  ),
                ],
                [html.text("Harpoon 5.2")],
              ),
              html.text("."),
            ]),
            html.div([attribute.class("home-links")], [
              link("/projects/", "See my projects"),
              link("/blog/", "Read the logbook"),
            ]),
          ]),
          html.figure([attribute.class("home-portrait portrait")], [
            html.div([attribute.class("portrait-frame")], [
              html.img([
                attribute.attribute("src", "/headshot.png"),
                attribute.attribute(
                  "alt",
                  "Extremely Handsome photo of John Murphy",
                ),
                attribute.attribute("width", "600"),
                attribute.attribute("height", "615"),
              ]),
            ]),
          ]),
        ],
      ),
    ]),
  )
}

fn link(path: String, label: String) -> Element(Nil) {
  html.a([attribute.attribute("href", path)], [html.text(label)])
}
