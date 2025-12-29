#import "../src/lib.typ": kanbun, hakubun, parse-kanbun, parse-wenyan, render-kanbun, yomikudasi
#set text(font: "Noto Serif CJK JP")

== 簡単な実例

次の実装の通り、`hundouk`パッケージを利用することで、プレーンテキスト形式の軽量なアノテーションを付与された漢文を@fig1 のように組版できます。

```typ
#import "{import-path}": kanbun

#kanbun(
  tight: false, // アキ組
  "月落チ烏啼キテ霜満ツ[レ]天ニ，
  江楓漁火対ス[二]愁眠ニ[一]。
  姑(こ)蘇(そ)城外ノ寒山寺，
  夜半ノ鐘声到ル[二]客船ニ[一]。"
)
```

#figure(
  caption: "レンダリングされた漢文",
  gap: 1em,
  kanbun(
    tight: false,
    "月落チ烏啼キテ霜満ツ[レ]天ニ，
    江楓漁火対ス[二]愁眠ニ[一]。
    姑(こ)蘇(そ)城外ノ寒山寺，
    夜半ノ鐘声到ル[二]客船ニ[一]。",
  ),
)<fig1>

`kanbun()`に`debug: true`と付ければ、色付きで構造が表示されます。

```typ
#import "{import-path}": kanbun

#kanbun(
  tight: false, // アキ組
  debug: true, // デバッグ色表示
  "月落チ烏啼キテ霜満ツ[レ]天ニ，
  江楓漁火対ス[二]愁眠ニ[一]。
  姑(こ)蘇(そ)城外ノ寒山寺，
  夜半ノ鐘声到ル[二]客船ニ[一]。"
)
```

#figure(
  caption: "漢文組版の構造",
  gap: 1em,
  kanbun(
    tight: false,
    debug: true,
    "月落チ烏啼キテ霜満ツ[レ]天ニ，
    江楓漁火対ス[二]愁眠ニ[一]。
    姑(こ)蘇(そ)城外ノ寒山寺，
    夜半ノ鐘声到ル[二]客船ニ[一]。",
  ),
)

== アキ組とベタ組

漢文の試験問題や漢詩、古典籍などでは、漢字や訓点全体が1つづつ等しいサイズのボックスのグリッドのようにレンダリングされることが多く、これを*アキ組*と呼びます。これと対照的に、訓点の有無によって動的に1つのブロックのサイズを調整するレイアウトを、*ベタ組*と呼びます。

#grid(
  columns: 2,
  column-gutter: 2em,
  row-gutter: 1em,
  ```typ
  #import "{import-path}": kanbun

  #kanbun(
    tight: false, // アキ組
    "月落チ烏啼キテ霜満ツ[レ]天ニ，
    江楓漁火対ス[二]愁眠ニ[一]。
    姑(こ)蘇(そ)城外ノ寒山寺，
    夜半ノ鐘声到ル[二]客船ニ[一]。"
  )
  ```,
  ```typ
  #import "{import-path}": kanbun

  #kanbun(
    tight: true, // ベタ組（デフォルト）
    "月落チ烏啼キテ霜満ツ[レ]天ニ，
    江楓漁火対ス[二]愁眠ニ[一]。
    姑(こ)蘇(そ)城外ノ寒山寺，
    夜半ノ鐘声到ル[二]客船ニ[一]。"
  )
  ```,

  align(
    center,
    kanbun(
      tight: false,
      "月落チ烏啼キテ霜満ツ[レ]天ニ，
    江楓漁火対ス[二]愁眠ニ[一]。
    姑(こ)蘇(そ)城外ノ寒山寺，
    夜半ノ鐘声到ル[二]客船ニ[一]。",
    ),
  ),
  align(
    center,
    kanbun(
      tight: true,
      "月落チ烏啼キテ霜満ツ[レ]天ニ，
    江楓漁火対ス[二]愁眠ニ[一]。
    姑(こ)蘇(そ)城外ノ寒山寺，
    夜半ノ鐘声到ル[二]客船ニ[一]。",
    ),
  ),
)


== 縦組と横書
現時点（Typst `v0.14`）においては、まだ公式に縦組モード（CSSで言う`writing-model: vertical-lr`）がサポートされておらず、そのため、`grid`や`stack`などを用いた擬似的な縦組しかできないため、本パッケージもこのように実装しました。縦組自体がサポートされていないため、本パッケージは現時点では横書きの文章の中で図のように漢文を組版するためのものです。

#grid(
  columns: 2,
  column-gutter: 2em,
  row-gutter: 1em,
  ```typ
  #import "{import-path}": kanbun

  #kanbun(
    writing-direction: ttb, // 縦組（デフォルト）
    "月落チ烏啼キテ霜満ツ[レ]天ニ，
    江楓漁火対ス[二]愁眠ニ[一]。
    姑(こ)蘇(そ)城外ノ寒山寺，
    夜半ノ鐘声到ル[二]客船ニ[一]。"
  )
  ```,
  ```typ
  #import "{import-path}": kanbun

  #kanbun(
    writing-direction: ltr, // 横組
    "月落チ烏啼キテ霜満ツ[レ]天ニ，
    江楓漁火対ス[二]愁眠ニ[一]。
    姑(こ)蘇(そ)城外ノ寒山寺，
    夜半ノ鐘声到ル[二]客船ニ[一]。"
  )
  ```,

  align(
    center,
    kanbun(
      writing-direction: ttb,
      "月落チ烏啼キテ霜満ツ[レ]天ニ，
    江楓漁火対ス[二]愁眠ニ[一]。
    姑(こ)蘇(そ)城外ノ寒山寺，
    夜半ノ鐘声到ル[二]客船ニ[一]。",
    ),
  ),
  align(
    center,
    kanbun(
      writing-direction: ltr,
      "月落チ烏啼キテ霜満ツ[レ]天ニ，
    江楓漁火対ス[二]愁眠ニ[一]。
    姑(こ)蘇(そ)城外ノ寒山寺，
    夜半ノ鐘声到ル[二]客船ニ[一]。",
    ),
  ),
)

== 字間・行間・改行
#import "./utils/display.typ": show-simple

#show-simple(
  ```typ
  #import "{import-path}": kanbun

  #kanbun(
    ruby-gutter: 1em,
    annotation-gutter: 1em,
    writing-direction: ttb,
    "學ビテ而不[㆑]厭ハ、誨ヘテ[㆑]人ヲ不[㆑]倦マ",
  )
  ```,
  kanbun(
    ruby-gutter: 1em,
    annotation-gutter: 1em,
    writing-direction: ttb,
    "學ビテ而不[㆑]厭ハ、誨ヘテ[㆑]人ヲ不[㆑]倦マ",
  ),
)



#figure(
  caption: "Connected Word Unit Test (TTB)",
  kanbun(
    debug: true,
    writing-direction: ttb,
    "東(とう)=京(きやう)=都(と)。",
  ),
)

#figure(
  caption: "Connected Word Unit Test (LTR)",
  kanbun(
    debug: true,
    writing-direction: ltr,
    "大=和(やまと)",
  ),
)

#figure(
  caption: "Merged Left Ruby Test",
  kanbun(
    debug: true,
    "於啁(てう)=啾(しゅ)‹ツイッター›ニ。",
  ),
)



#v(2em)
Left Side Attachments (parse-kanbun):
#render-kanbun(parse-kanbun("漢‹かん›«な»字[レ]"))
#render-kanbun(writing-direction: ltr, parse-kanbun("漢‹かん›«な»字[レ]"))

// #paragraphs


// #let ruby-scale = 0.5


// #let color-connector = orange

// #let connector = grid.cell(inset: (y: -0.2em), move(dx: 0.4em, rotate(90deg, text(fill: color-connector)[-])))

// #grid(
//   columns: 3,
//   grid(

//   ),
//   grid(
//     gutter: 0.2em,
//     "山",
//     connector,
//     "火",
//     "者"
//   ),
//   [
//     #set text(size: ruby-scale * 1em)
//     #grid(
//       "や",
//       "ま",
//       "び",
//       gutter: 0.2em,
//     )
//   ],
// )
//



#let show-example(text, ..args) = [
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
#show-example(
  "學ビテ而時ニ習フ[㆑]之ヲ、不[㆓]亦タ説バシカラ[㆒]乎？有リ[㆑]朋自リ[㆓]遠方[㆒]来タル、不[㆓]亦タ樂シカラ[㆒]乎？人不シテ[㆑]知ラ而不[㆑]慍ミ、不[㆓]亦タ君子ナラ[㆒]乎？",
  tight: true,
)

#show-example(
  "能ク以テ[二]禮=讓ヲ[一]爲（をさ）ムル[レ]国ヲ乎、何有ラン？不ンバ[レ]能ハ[下]以テ[二]禮=讓ヲ[一]爲（をさ）ムル[上レ]國ヲ、如[レ]禮ヲ何セン。",
  tight: false,
)


#show-example("其ノ人弗ル能ハ應フル也。")

