import lustre/attribute
import lustre/element.{type Element}
import lustre/element/html
import site/layout

pub fn view() -> Element(Nil) {
  layout.view(
    "Resume",
    "/resume/",
    "/resume/",
    html.main([attribute.class("page resume-page")], [
      html.p([attribute.class("eyebrow")], [html.text("RESUME")]),
      html.h1([], [html.text("A brief history of work.")]),
      html.p([attribute.class("lede")], [
        html.text(
          "The concise version of where I've studied, what I've worked on, and what I bring to the table.",
        ),
      ]),
      html.div([attribute.class("resume-sections")], [
        html.section([attribute.class("resume-section")], [
          html.h2([], [html.text("Education")]),
          html.article([attribute.class("resume-entry")], [
            html.div([], [
              html.h3([], [html.text("Georgia Institute of Technology")]),
              html.p([], [html.text("Computer Science")]),
            ]),
          ]),
        ]),
        html.section([attribute.class("resume-section")], [
          html.h2([], [html.text("Experience")]),
          html.article([attribute.class("resume-entry resume-placeholder")], [
            html.div([], [
              html.h3([], [html.text("Work history coming soon")]),
              html.p([], [
                html.text(
                  "This section is ready for roles, dates, and the work worth highlighting.",
                ),
              ]),
            ]),
          ]),
        ]),
      ]),
    ]),
  )
}
