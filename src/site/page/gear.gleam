import lustre/attribute
import lustre/element.{type Element}
import lustre/element/html
import site/layout

pub fn view() -> Element(Nil) {
  layout.view(
    "Gear",
    "/gear/",
    "/gear/",
    html.main([attribute.class("page gear-page")], [
      html.p([attribute.class("eyebrow")], [html.text("GEAR")]),
      html.h1([], [html.text("Tools of the trade.")]),
      html.p([attribute.class("lede")], [
        html.text("A list of the hardware and machines I use every day."),
      ]),
      html.dl([attribute.class("setup-grid gear-grid")], [
        setup_item("Computers", [
          html.li([], [html.text("MacBook Pro 16-inch (M3 Pro)")]),
          html.li([], [
            html.text("SFFPC"),
            html.ul([attribute.class("setup-subvalues")], [
              html.li([], [html.text("NCASE M1")]),
              html.li([], [html.text("AMD Ryzen 9 5900X")]),
              html.li([], [html.text("NVIDIA GeForce RTX 3080 Ti FE")]),
            ]),
          ]),
        ]),
        setup_item("Keyboard", [
          html.li([], [
            html.a(
              [
                attribute.attribute(
                  "href",
                  "https://typeractive.xyz/products/corne-wireless-premium-aluminum-case",
                ),
              ],
              [html.text("Typeractive Corne Aluminum")],
            ),
          ]),
        ]),
        setup_item("Headphones", [
          html.li([], [html.text("Sony WH-1000XM5")]),
        ]),
        setup_item("Rides", [
          html.li([], [html.text("Honda S2000")]),
          html.li([], [html.text("1999 Ford F-250 7.3")]),
        ]),
      ]),
    ]),
  )
}

fn setup_item(label: String, items: List(Element(Nil))) -> Element(Nil) {
  html.div([attribute.class("setup-item")], [
    html.dt([], [html.text(label)]),
    html.dd([], [html.ul([attribute.class("setup-values")], items)]),
  ])
}
