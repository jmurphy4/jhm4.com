import lustre/attribute
import lustre/element.{type Element}
import lustre/element/html

pub fn view(
  title: String,
  active_path: String,
  page_path: String,
  content: Element(Nil),
) -> Element(Nil) {
  html.html([attribute.attribute("lang", "en")], [
    html.head([], [
      html.meta([attribute.attribute("charset", "utf-8")]),
      html.meta([
        attribute.attribute("name", "viewport"),
        attribute.attribute("content", "width=device-width, initial-scale=1"),
      ]),
      html.meta([
        attribute.attribute("name", "theme-color"),
        attribute.attribute("content", "#f3efe4"),
      ]),
      html.meta([
        attribute.attribute("name", "description"),
        attribute.attribute(
          "content",
          "John Murphy's personal site and logbook.",
        ),
      ]),
      html.meta([
        attribute.attribute("property", "og:title"),
        attribute.attribute("content", social_title(title, page_path)),
      ]),
      html.meta([
        attribute.attribute("property", "og:description"),
        attribute.attribute(
          "content",
          "John Murphy's personal site and logbook.",
        ),
      ]),
      html.meta([
        attribute.attribute("property", "og:site_name"),
        attribute.attribute("content", "John Murphy"),
      ]),
      html.meta([
        attribute.attribute("property", "og:type"),
        attribute.attribute("content", "website"),
      ]),
      html.meta([
        attribute.attribute("property", "og:url"),
        attribute.attribute("content", "https://www.jhm4.com" <> page_path),
      ]),
      html.meta([
        attribute.attribute("property", "og:image"),
        attribute.attribute(
          "content",
          "https://www.jhm4.com/social-preview.png",
        ),
      ]),
      html.meta([
        attribute.attribute("property", "og:image:width"),
        attribute.attribute("content", "1200"),
      ]),
      html.meta([
        attribute.attribute("property", "og:image:height"),
        attribute.attribute("content", "630"),
      ]),
      html.meta([
        attribute.attribute("property", "og:image:alt"),
        attribute.attribute("content", "A sailboat crossing calm blue waves"),
      ]),
      html.title([], title <> " · John Murphy"),
      html.script([], theme_script),
      html.script([], browser_script),
      html.link([
        attribute.attribute("rel", "icon"),
        attribute.attribute("type", "image/svg+xml"),
        attribute.attribute("href", "/favicon.svg?v=2"),
      ]),
      html.link([
        attribute.attribute("rel", "apple-touch-icon"),
        attribute.attribute("href", "/apple-touch-icon.png"),
      ]),
      html.link([
        attribute.attribute("rel", "stylesheet"),
        attribute.attribute("href", "/styles.css"),
      ]),
      html.link([
        attribute.attribute("rel", "alternate"),
        attribute.attribute("type", "application/atom+xml"),
        attribute.attribute("title", "John Murphy's logbook"),
        attribute.attribute("href", "/atom.xml"),
      ]),
    ]),
    html.body([], [site_header(active_path), content, site_footer()]),
  ])
}

fn site_header(active_path: String) -> Element(Nil) {
  html.header([class("site-header")], [
    html.div(
      [class("sailing-lane"), attribute.attribute("aria-hidden", "true")],
      [
        html.div([class("boat-track")], [
          html.div([class("boat-bob")], [
            html.div([class("sailboat")], [
              html.span([class("mast")], []),
              html.span([class("sail sail-main")], []),
              html.span([class("sail sail-spinnaker")], []),
              html.span([class("hull")], []),
              html.span([class("boat-wave wave-one")], []),
              html.span([class("boat-wave wave-two")], []),
              html.span([class("boat-wave wave-three")], []),
            ]),
          ]),
        ]),
        html.div([class("waterline")], []),
      ],
    ),
    html.nav([attribute.attribute("aria-label", "Primary navigation")], [
      html.a(nav_attributes("/", active_path == "/"), [
        html.span([class("site-name")], [html.text("JM")]),
      ]),
      html.div(
        [class("nav-links"), attribute.attribute("id", "primary-links")],
        [
          nav_link("/", "Home", active_path),
          nav_link("/about/", "About", active_path),
          nav_link("/projects/", "Projects", active_path),
          nav_link("/resume/", "Resume", active_path),
          nav_link("/gear/", "Gear", active_path),
          nav_link("/blog/", "Blog", active_path),
        ],
      ),
      html.div([class("nav-actions")], [
        html.button(
          [
            class("theme-toggle"),
            attribute.attribute("type", "button"),
            attribute.attribute("id", "theme-toggle"),
            attribute.attribute("aria-label", "Switch color theme"),
          ],
          [
            html.span(
              [
                class("theme-icon theme-moon"),
                attribute.attribute("aria-hidden", "true"),
              ],
              [html.text("☾")],
            ),
            html.span(
              [
                class("theme-icon theme-sun"),
                attribute.attribute("aria-hidden", "true"),
              ],
              [html.text("☀")],
            ),
          ],
        ),
        html.button(
          [
            class("menu-toggle"),
            attribute.attribute("type", "button"),
            attribute.attribute("id", "menu-toggle"),
            attribute.attribute("aria-controls", "primary-links"),
            attribute.attribute("aria-expanded", "false"),
            attribute.attribute("aria-label", "Open navigation menu"),
          ],
          [html.span([], []), html.span([], []), html.span([], [])],
        ),
      ]),
    ]),
  ])
}

fn nav_link(path: String, label: String, active_path: String) -> Element(Nil) {
  html.a(nav_attributes(path, path == active_path), [html.text(label)])
}

fn nav_attributes(
  path: String,
  active: Bool,
) -> List(attribute.Attribute(Nil)) {
  let base = [attribute.attribute("href", path)]
  case active {
    True -> [
      attribute.attribute("aria-current", "page"),
      class("active"),
      ..base
    ]
    False -> base
  }
}

fn site_footer() -> Element(Nil) {
  html.footer([class("site-footer")], [
    html.p([], [
      html.text("Built with "),
      html.a([attribute.attribute("href", "https://gleam.run")], [
        html.text("Gleam"),
      ]),
      html.text(", "),
      html.a([attribute.attribute("href", "https://lustre.hexdocs.pm")], [
        html.text("Lustre"),
      ]),
      html.text(", and possibly Belgian beer."),
    ]),
    html.p([class("footer-mark")], [
      html.text("© "),
      html.span([attribute.attribute("id", "copyright-year")], []),
    ]),
  ])
}

fn class(value: String) -> attribute.Attribute(msg) {
  attribute.class(value)
}

fn social_title(title: String, active_path: String) -> String {
  case active_path {
    "/" -> "Murphy's Site"
    "/about/" -> "About Murphy"
    "/projects/" -> "Murphy's Projects"
    "/resume/" -> "Murphy's Resume"
    "/gear/" -> "Murphy's Gear"
    "/blog/" -> "Murphy's Blog"
    _ -> title
  }
}

const theme_script = "(()=>{const root=document.documentElement,key='site-theme',media=matchMedia('(prefers-color-scheme: dark)');let initial=media.matches?'dark':'light';try{initial=localStorage.getItem(key)||initial}catch(_){}root.dataset.theme=initial;document.addEventListener('DOMContentLoaded',()=>{const button=document.getElementById('theme-toggle'),meta=document.querySelector('meta[name=theme-color]');if(!button)return;const apply=theme=>{root.dataset.theme=theme;try{localStorage.setItem(key,theme)}catch(_){}if(meta)meta.content=theme==='dark'?'#0d1b24':'#f3efe4';button.setAttribute('aria-label',theme==='dark'?'Switch to light mode':'Switch to dark mode')};apply(initial);button.addEventListener('click',()=>{const next=root.dataset.theme==='dark'?'light':'dark',rect=button.getBoundingClientRect(),x=rect.left+rect.width/2,y=rect.top+rect.height/2,radius=Math.hypot(Math.max(x,innerWidth-x),Math.max(y,innerHeight-y));root.style.setProperty('--theme-x',`${x}px`);root.style.setProperty('--theme-y',`${y}px`);root.style.setProperty('--theme-radius',`${radius}px`);const change=()=>apply(next);if(!document.startViewTransition||matchMedia('(prefers-reduced-motion: reduce)').matches){change();return}document.startViewTransition(change)})})})()"

const browser_script = "try{const key='boat-voyage-start',duration=38000,now=Date.now();let start=Number(sessionStorage.getItem(key));if(!start||start>now){start=now;sessionStorage.setItem(key,String(start))}const elapsed=(now-start)%duration;document.documentElement.style.setProperty('--sail-delay',`${-elapsed}ms`)}catch(_){}document.addEventListener('DOMContentLoaded',()=>{const year=document.getElementById('copyright-year');if(year)year.textContent=String(new Date().getFullYear());const toggle=document.getElementById('menu-toggle'),links=document.getElementById('primary-links');if(toggle&&links){toggle.addEventListener('click',()=>{const open=links.classList.toggle('is-open');toggle.classList.toggle('is-open',open);toggle.setAttribute('aria-expanded',String(open));toggle.setAttribute('aria-label',open?'Close navigation menu':'Open navigation menu')})}if(!navigator.connection?.saveData){const prefetched=new Set(),prefetch=anchor=>{const url=new URL(anchor.href);if(url.origin!==location.origin||prefetched.has(url.href))return;prefetched.add(url.href);fetch(url.href,{credentials:'same-origin'}).catch(()=>{})};document.querySelectorAll('a[href]').forEach(anchor=>{anchor.addEventListener('pointerenter',()=>prefetch(anchor),{once:true});anchor.addEventListener('focus',()=>prefetch(anchor),{once:true});anchor.addEventListener('touchstart',()=>prefetch(anchor),{once:true,passive:true})})}})"
