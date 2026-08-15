import gleam/list
import gleam/string
import site/post

pub fn atom() -> String {
  let entries =
    post.all()
    |> list.map(fn(post) {
      "<entry><title>"
      <> xml_escape(post.title)
      <> "</title><id>https://www.jhm4.com/blog/"
      <> post.slug
      <> "/</id><link href=\"https://www.jhm4.com/blog/"
      <> post.slug
      <> "/\"/><updated>"
      <> post.published_iso
      <> "</updated><summary>"
      <> xml_escape(post.description)
      <> "</summary></entry>"
    })
    |> string.join("")

  let updated = case post.all() {
    [first, ..] -> first.published_iso
    [] -> "2026-01-01T00:00:00-05:00"
  }

  "<?xml version=\"1.0\" encoding=\"utf-8\"?><feed xmlns=\"http://www.w3.org/2005/Atom\"><title>John Murphy's logbook</title><id>https://www.jhm4.com/blog/</id><link href=\"https://www.jhm4.com/blog/\"/><link rel=\"self\" href=\"https://www.jhm4.com/atom.xml\"/><updated>"
  <> updated
  <> "</updated><author><name>John Murphy</name></author><subtitle>Notes about software, projects, and whatever else stays on my mind.</subtitle>"
  <> entries
  <> "</feed>"
}

fn xml_escape(value: String) -> String {
  value
  |> string.replace(each: "&", with: "&amp;")
  |> string.replace(each: "<", with: "&lt;")
  |> string.replace(each: ">", with: "&gt;")
  |> string.replace(each: "\"", with: "&quot;")
  |> string.replace(each: "'", with: "&apos;")
}
