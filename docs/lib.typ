#import "@preview/rubby:0.10.2": get-ruby
#let ruby = get-ruby(
  size: 0.65em, // Ruby font size
  dy: 2pt, // Vertical offset of the ruby
  pos: top, // Ruby position (top or bottom)
  alignment: "center", // Ruby alignment ("center", "start", "between", "around")
  delimiter: "|", // The delimiter between words
  auto-spacing: true, // Automatically add necessary space around words
)

#let doc(
  author: none,
  title: none,
  subtitle: none,
  body,
) = {
  set document(title: title)

  set text(lang: "ja")

  show raw: set text(font: ("Fira Code", "Noto Sans Mono CJK JP"), size: 1em)
  show raw.where(block: false): set text(size: 1em)
  show raw.where(block: true): block.with(
    fill: luma(240),
    inset: 10pt,
    radius: 4pt,
  )
  show raw.where(block: true): it => align(center, it)


  set text(font: "Noto Serif CJK JP", size: 10pt)

  set heading(numbering: "1.1.")
  show heading: set block(spacing: 1em)

  set page(paper: "a4")

  show link: it => {
    set text(fill: blue)
    underline(it)
  }

  let title-block(body) = {
    set text(font: "Noto Serif CJK JP", size: 2em)
    align(center, body)
  }
  title-block(title)

  let subtitle-block(body) = {
    block(spacing: 2em)[
      #set text(font: "Noto Serif CJK JP", size: 1.25em)
      #align(center, body)
    ]
  }
  if subtitle != none {
    subtitle-block(subtitle)
  }

  let author-block(body) = {
    set text(font: "Noto Serif CJK JP", size: 1.25em)
    align(center, body)
  }
  author-block(author)

  let balance(content) = layout(size => {
    let count = content.at("count")
    let textheight = measure(content, width: size.width).height / count
    let height = measure(content, height: textheight + 9pt, width: size.width).height
    block(height: height, content)
  })

  heading("目次", numbering: none, outlined: false)
  show outline.entry: set text(fill: rgb("#1a01ff"))
  balance(
    columns(2)[
      #outline(title: none, depth: 3)
    ],
  )

  body
}
