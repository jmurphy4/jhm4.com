pub type Post {
  Post(
    slug: String,
    title: String,
    description: String,
    published: String,
    published_iso: String,
    source: String,
  )
}

pub fn all() -> List(Post) {
  [
    Post(
      slug: "coming-soon",
      title: "Coming soon",
      description: "The logbook is getting ready to set sail.",
      published: "August 14, 2026",
      published_iso: "2026-08-14T00:00:00-04:00",
      source: "content/blog/coming-soon.md",
    ),
  ]
}
