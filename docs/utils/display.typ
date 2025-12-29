#import "../../src/lib.typ": kanbun, hakubun, yomikudasi

#let show-simple(code, result) = {
  set align(center)
  grid(
    row-gutter: 1em,
    inset: 0.5em,
    code, result
  )
}


#let show-compare((code-a, result-a), (code-b, result-b)) = {
  set align(center)
  grid(
    columns: 2,
    column-gutter: 2em,
    row-gutter: 1em,
    inset: 0.5em,
    code-a, code-b,
    result-a, result-b,
  )
}

#let show-example(text, ..args) = [
  #set heading(outlined: false)
  === #hakubun(text)
  #show box: set align(center)
  #show raw: set align(left)
  #box(
    width: 75%,
    grid(
      columns: 2,
      inset: 1em,
      grid.cell(
        colspan: 2,
        {
          let pos-args = if (args.pos().len() > 0) {
            repr(args.pos()).slice(0, -2) + ", "
          } else {
            ""
          }

          let named-args = if (args.named().len() > 0) {
            repr(args.named()).slice(1, -1)
          } else {
            ""
          }
          raw(
            "#import \"{import-path}\": kanbun\n\n#kanbun(\""
              + text
              + "\", height: 10em"
              + if pos-args.len() > 0 or named-args.len() > 0 {
                ", "
              } else {
                ""
              }
              + pos-args
              + named-args
              + ")",
            lang: "typ",
            block: true,
          )
        },
      ),
      kanbun(text, height: 10em, ..args),
      [
        #set align(horizon)
        #set par(leading: 1em)
        #yomikudasi(text)
      ],
    ),
  )
]
