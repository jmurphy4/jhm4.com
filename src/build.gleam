import gleam/io
import gleam/list
import lustre/element
import simplifile
import site/feed
import site/page/blog
import site/page/gear
import site/page/home
import site/page/post as post_page
import site/page/projects
import site/page/resume
import site/post

pub fn main() {
  let assert Ok(_) = simplifile.delete_all(["./dist"])
  let assert Ok(_) = simplifile.copy_directory(at: "./public", to: "./dist")
  let assert Ok(_) = simplifile.delete_all(["./dist/.DS_Store"])

  write_page("./dist", "./dist/index.html", home.view())
  write_redirect("./dist/about", "./dist/about/index.html", "/#about")
  write_page("./dist/blog", "./dist/blog/index.html", blog.view())
  write_page("./dist/gear", "./dist/gear/index.html", gear.view())
  write_page("./dist/projects", "./dist/projects/index.html", projects.view())
  write_page("./dist/resume", "./dist/resume/index.html", resume.view())
  let assert Ok(_) =
    simplifile.write(to: "./dist/atom.xml", contents: feed.atom())

  post.all()
  |> list.each(fn(post) {
    let directory = "./dist/blog/" <> post.slug
    write_page(directory, directory <> "/index.html", post_page.view(post))
  })

  io.println("Built site in dist/")
}

fn write_redirect(directory: String, path: String, target: String) -> Nil {
  let assert Ok(_) = simplifile.create_directory_all(directory)
  let html =
    "<!doctype html><html lang=\"en\"><head><meta charset=\"utf-8\"><meta http-equiv=\"refresh\" content=\"0; url="
    <> target
    <> "\"><link rel=\"canonical\" href=\"https://www.jhm4.com"
    <> target
    <> "\"><title>About Murphy</title></head><body><p><a href=\""
    <> target
    <> "\">Continue to About Murphy</a></p></body></html>"
  let assert Ok(_) = simplifile.write(to: path, contents: html)
  Nil
}

fn write_page(
  directory: String,
  path: String,
  page: element.Element(Nil),
) -> Nil {
  let assert Ok(_) = simplifile.create_directory_all(directory)
  let html = element.to_document_string(page)
  let assert Ok(_) = simplifile.write(to: path, contents: html)
  Nil
}
