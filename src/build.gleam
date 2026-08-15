import gleam/io
import gleam/list
import lustre/element
import simplifile
import site/feed
import site/page/about
import site/page/blog
import site/page/home
import site/page/post as post_page
import site/post

pub fn main() {
  let assert Ok(_) = simplifile.delete_all(["./dist"])
  let assert Ok(_) = simplifile.copy_directory(at: "./public", to: "./dist")
  let assert Ok(_) = simplifile.delete_all(["./dist/.DS_Store"])

  write_page("./dist", "./dist/index.html", home.view())
  write_page("./dist/about", "./dist/about/index.html", about.view())
  write_page("./dist/blog", "./dist/blog/index.html", blog.view())
  let assert Ok(_) =
    simplifile.write(to: "./dist/atom.xml", contents: feed.atom())

  post.all()
  |> list.each(fn(post) {
    let directory = "./dist/blog/" <> post.slug
    write_page(directory, directory <> "/index.html", post_page.view(post))
  })

  io.println("Built site in dist/")
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
