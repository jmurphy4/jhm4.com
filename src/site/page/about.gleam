import lustre/attribute
import lustre/element.{type Element}
import lustre/element/html
import site/layout

pub fn view() -> Element(Nil) {
  layout.view(
    "About",
    "/about/",
    "/about/",
    html.main([attribute.class("page prose-page")], [
      html.p([attribute.class("eyebrow")], [html.text("ABOUT")]),
      html.h1([], [html.text("A person behind the screen.")]),
      html.div([attribute.class("about-layout")], [
        html.figure([attribute.class("portrait")], [
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
        html.div([attribute.class("prose")], [
          html.p([], [
            html.text(
              "I'm Murphy. I like building thoughtful software, learning new things, and following an idea far enough to see where it leads.",
            ),
          ]),
          html.p([], [
            html.text(
              "I studied computer science at Georgia Tech. After graduating I went to Washington D.C. then Florida, and I'm now based in Richmond, Virginia. This site is a place to share what I'm working on, what I'm learning, and random musings (eventually).",
            ),
          ]),
          html.p([], [
            html.text(
              "Away from a keyboard, I appreciate spending time with good friends, sailing my Harpoon 5.2, riding horses, and projects that take me away from the keyboard 😉",
            ),
          ]),
        ]),
      ]),
    ]),
  )
}
