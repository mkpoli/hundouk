#import "../lib.typ": ruby, ruby-tight
#import "../../src/lib.typ": hakubun, kanbun, parse-kanbun, parse-wenyan, render-kanbun, yomikudasi
#import "../utils/display.typ": show-compare, show-simple
#set text(font: "Noto Serif CJK JP")

== 簡単な実例

次の実装の通り、`hundouk`パッケージを利用することで、プレーンテキスト形式の軽量なアノテーションを付与された漢文を@fig1 のように組版できます。

#let 送元二使安西 = "
  渭城ノ朝雨浥(うるお)シ[二]輕塵ヲ[一]
  客舍青青柳色新タナリ
  勸ム[レ]君ニ更ニ盡セ一杯ノ酒
  西ノカタ出ヅレバ[二]陽關ヲ[一]無[二]カラン故人[一]".trim()

#raw(
  block: true,
  lang: "typ",
  "#import \"{import-path}\": kanbun\n\n#kanbun(\n  tight: false, // アキ組\n  \"" + 送元二使安西 + "\"\n)",
)

#figure(
  kind: "example",
  supplement: [例],
  caption: [〔唐〕王維《送元二使安西》],
  gap: 1em,
  kanbun(
    tight: false,
    送元二使安西,
  ),
)<fig1>


`kanbun()`に`debug: true`と付ければ、色付きで構造が表示されます。

#raw(
  block: true,
  lang: "typ",
  "#import \"{import-path}\": kanbun\n\n#kanbun(\n  tight: false, // アキ組\n  debug: true, // デバッグ色表示\n  \""
    + 送元二使安西
    + "\"\n)",
)
#figure(
  kind: "example",
  supplement: [例],
  caption: "漢文組版の構造",
  gap: 1em,
  kanbun(
    tight: false,
    debug: true,
    送元二使安西,
  ),
)

== アキ組とベタ組

漢文の試験問題や漢詩、古典籍などでは、漢字や訓点全体が1つづつ等しいサイズのボックスのグリッドのようにレンダリングされることが多く、これを*アキ組*と呼びます。これと対照的に、訓点の有無によって動的に1つのブロックのサイズを調整するレイアウトを、*ベタ組*と呼びます。

#show-compare(
  shared-caption: "〔唐〕張継《楓橋夜泊》",
  (
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
    kanbun(
      tight: false,
      "月落チ烏啼キテ霜満ツ[レ]天ニ，
      江楓漁火対ス[二]愁眠ニ[一]。
      姑(こ)蘇(そ)城外ノ寒山寺，
      夜半ノ鐘声到ル[二]客船ニ[一]。",
    ),
  ),
  (
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
    writing-direction: ttb, // 縦組（デフォ）
    "床前看[二]ル月光ヲ[一]，
    疑ウラクハ[二]是レ地上ノ霜カト[一]。
    舉[レ]ゲテ頭ヲ望ム[二]山月ヲ[一]，
    低[レ]レテ頭ヲ思フ[二]故鄕ヲ[一]。"
  )
  ```,
  ```typ
  #import "{import-path}": kanbun

  #kanbun(
    writing-direction: ltr, // 横組
    "床前看[二]ル月光ヲ[一]，
    疑ウラクハ[二]是レ地上ノ霜カト[一]。
    舉[レ]ゲテ頭ヲ望ム[二]山月ヲ[一]，
    低[レ]レテ頭ヲ思フ[二]故鄕ヲ[一]。"
  )
  ```,

  align(
    center,
    kanbun(
      writing-direction: ttb,
      "床前看[二]ル月光ヲ[一]，
    疑ウラクハ[二]是レ地上ノ霜カト[一]。
    舉[レ]ゲテ頭ヲ望ム[二]山月ヲ[一]，
    低[レ]レテ頭ヲ思フ[二]故鄕ヲ[一]。",
    ),
  ),
  align(
    center,
    kanbun(
      writing-direction: ltr,
      "床前看[二]ル月光ヲ[一]，
    疑ウラクハ[二]是レ地上ノ霜カト[一]。
    舉[レ]ゲテ頭ヲ望ム[二]山月ヲ[一]，
    低[レ]レテ頭ヲ思フ[二]故鄕ヲ[一]。",
    ),
  ),
)

== 返点と送り仮名の位置

`kaeriten-offset`オプションを使用することで、返り点の位置をずらすこともできます.

#import "../utils/display.typ": show-compare

#show-compare(
  shared-caption: "〔唐〕王之渙《登鸛鵲樓》",
  (
    ```typ
    #import "{import-path}": kanbun
    #kanbun(
      kaeriten-offset: 0pt, // デフォルト
      okurigana-x-offset: 0pt, // デフォルト
      okurigana-y-offset: 0pt, // デフォルト
      tight: false,
      "白日依リテ[レ]山ニ盡キ，
      黄河入リテ[レ]海ニ流ル。
      欲シ[二]窮メント[一]千里ノ目ヲ，
      更ニ上ル一層ノ樓。"
    )
    ```,
    kanbun(
      kaeriten-offset: 0pt,
      okurigana-x-offset: 0pt,
      okurigana-y-offset: 0pt,
      tight: false,
      "白日依リテ[レ]山ニ盡キ，
      黄河入リテ[レ]海ニ流ル。
      欲シ[二]窮メント[一]千里ノ目ヲ，
      更ニ上ル一層ノ樓。",
    ),
  ),
  (
    ```typ
    #import "{import-path}": kanbun
    #kanbun(
      kaeriten-offset: -0.25em,
      okurigana-x-offset: 0pt,
      okurigana-y-offset: 0.125em,
      tight: false,
      "白日依リテ[レ]山ニ盡キ，
      黃河入リテ[レ]海ニ流ル。
      欲シ[二]窮メント[一]千里ノ目ヲ，
      更ニ上ル一層ノ樓。"
    )
    ```,
    kanbun(
      kaeriten-offset: -0.25em,
      okurigana-x-offset: 0pt,
      okurigana-y-offset: 0.125em,
      tight: false,
      "白日依リテ[レ]山ニ盡キ，
      黄河入リテ[レ]海ニ流ル。
      欲シ[二]窮メント[一]千里ノ目ヲ，
      更ニ上ル一層ノ樓。",
    ),
  ),
)

== 文字サイズ

#let 早発白帝城 = "朝ニ辭ス[二]白帝彩雲間ヲ[一]
  千里江陵一日ニシテ還ル
  兩岸猿聲啼イテ不[レ]住(や)マザルニ
  輕舟已ニ過グ[二]萬重山ヲ[一]"

#show-compare(
  shared-caption: "〔唐〕李白《早発白帝城》",
  (
    raw(
      block: true,
      lang: "typ",
      "#import \"{import-path}\": kanbun\n#kanbun(\n  ruby-size: 0.5em, // デフォルト\n  okurigana-size: 0.5em, // デフォルト\n  tight: false, \n  \""
        + 早発白帝城
        + "\"\n)",
    ),
    kanbun(
      ruby-size: 0.5em,
      okurigana-size: 0.5em,
      tight: false,
      早発白帝城,
    ),
  ),
  (
    raw(
      block: true,
      lang: "typ",
      "#import \"{import-path}\": kanbun\n#kanbun(\n  ruby-size: 0.35em, // 小さめ\n  okurigana-size: 0.35em, // 小さめ\n  tight: false,\n  \""
        + 早発白帝城
        + "\"\n)",
    ),
    kanbun(
      ruby-size: 0.35em,
      okurigana-size: 0.35em,
      tight: false,
      早発白帝城,
    ),
  ),
)


== 字間・行間・改行

`ruby-tracking`と`okurigana-tracking`はデフォルトで`auto`となっており、縦組（TTB）の場合は`0.1em`、横組（LTR）の場合は`0.01em`に自動設定されます。
#show-simple(
  ```typ
  #import "{import-path}": kanbun

  #kanbun(
    ruby-gutter: 0.5em,
    ruby-tracking: 0.5em,
    okurigana-tracking: 0.5em,
    annotation-gutter: 0.5em,

    height: 8em,
    "學ビテ而不[㆑]厭ハ
    誨ヘテ[㆑]人ヲ不[㆑]倦マ",
  )
  ```,
  kanbun(
    ruby-gutter: 0.5em,
    ruby-tracking: 0.5em,
    okurigana-tracking: 0.5em,
    annotation-gutter: 0.5em,
    height: 8em,
    "學ビテ而不[㆑]厭ハ
    誨ヘテ[㆑]人ヲ不[㆑]倦マ",
  ),
)

行間や字間を調整する例です。

#import "../texts/poems.typ": 春望
#show-compare(
  shared-caption: "〔唐〕杜甫《春望》",
  (
    raw(
      block: true,
      lang: "typ",
      "#import \"{import-path}\": kanbun\n#kanbun(\n  char-spacing: 0.05em, // デフォルト\n  line-spacing: auto, // デフォルト\n  \""
        + 春望
        + "\"\n)",
    ),
    kanbun(
      char-spacing: 0.05em,
      line-spacing: auto,
      春望,
    ),
  ),
  (
    raw(
      block: true,
      lang: "typ",
      "#import \"{import-path}\": kanbun\n#kanbun(\n  char-spacing: 0.5em, // 字間を広げる\n  line-spacing: 1em, // 行間を広げる\n  \""
        + 春望
        + "\"\n)",
    ),
    kanbun(
      char-spacing: 0.5em,
      line-spacing: 1em,
      春望,
    ),
  ),
)


== ルビの縦方向位置

`ruby-vertical-offset`オプションで、縦書き時のルビの縦方向の位置を微調整できます。フォントによってはルビが親文字に近すぎたり遠すぎたりする場合に有効です。
#import "../texts/poems.typ": 黄鶴楼
#show-compare(
  shared-caption: "〔唐〕崔顥《黄鶴楼》",
  (
    raw(
      block: true,
      lang: "typ",
      "#import \"{import-path}\": kanbun\n#kanbun(\n  ruby-vertical-offset: 0.05em, // デフォルト\n  \""
        + 黄鶴楼
        + "\"\n)",
    ),
    kanbun(
      ruby-vertical-offset: 0.05em,
      黄鶴楼,
    ),
  ),
  (
    raw(
      block: true,
      lang: "typ",
      "#import \"{import-path}\": kanbun\n#kanbun(\n  ruby-vertical-offset: 0.2em, // 調整（下げる）\n  \""
        + 黄鶴楼
        + "\"\n)",
    ),
    kanbun(
      ruby-vertical-offset: 0.2em,
      黄鶴楼,
    ),
  ),
)

== Unicode漢文記号

`use-unicode-kanbun`オプションを`true`（デフォルト）にすると、Unicodeの漢文記号（Kanbun Block, U+3190..U+319F）を使用します。`false`にすると、互換性のために通常の文字（`[一]`など）で近似してレンダリングします。`false`の場合はフォントが漢文記号を持っていなくても表示できる場合がありますが、見た目は異なります。
#import "../texts/poems.typ": 江雪
#show-compare(
  shared-caption: "〔唐〕柳宗元《江雪》",
  (
    raw(
      block: true,
      lang: "typ",
      "#import \"{import-path}\": kanbun\n#kanbun(\n  use-unicode-kanbun: true, // デフォルト\n  \"" + 江雪 + "\"\n)",
    ),
    kanbun(
      use-unicode-kanbun: true,
      江雪,
    ),
  ),
  (
    raw(
      block: true,
      lang: "typ",
      "#import \"{import-path}\": kanbun\n#kanbun(\n  use-unicode-kanbun: false, // 標準文字で近似\n  \""
        + 江雪
        + "\"\n)",
    ),
    kanbun(
      use-unicode-kanbun: false,
      江雪,
    ),
  ),
)

== 竪線（縦棒・ハイフン）

「`=`」（`U+003D` `EQUALS SIGN`、半角等号）または「`―`」（`U+2015` `HORIZONTAL BAR`、横棒）を漢字グループの間に置くことで、漢字同士を#ruby-tight[たてせん][竪線]（または#ruby-tight[たてぼう][縦棒]・#ruby-tight[hyphen][ハイフン]とも言う）で結ぶことができます。縦組では、以下のように返点がハイフンの横につく。

// #kanbun(debug: true, writing-direction: ltr, "發(た)[二]ツ大=和ニ(やまと)[一]")
// #kanbun(debug: true, "發(た)[二]ツ大=和ニ(やまと)[一]")
#show-compare(
  (
    ```typ
    #import "{import-path}": kanbun

    #kanbun(
      writing-direction: ttb,
      "發(た)[二]ツ大=和(やまと)ニ[一]",
    )
    ```,
    kanbun(
      writing-direction: ttb,
      "發(た)[二]ツ大=和(やまと)ニ[一]",
    ),
  ),
  (
    ```typ
    #import "{import-path}": kanbun

    #kanbun(
      writing-direction: ltr,
      "發(た)[二]ツ大=和(やまと)ニ[一]",
    )
    ```,
    kanbun(
      writing-direction: ltr,
      "發(た)[二]ツ大=和(やまと)ニ[一]",
    ),
  ),
)

3つ以上の場合は、`max-chars-for-kaeriten-hanging-on-hyphen`オプションで制御することで、最後のハイフンにつくか、最後の文字の左下につくかの選択ができます。

#show-compare(
  (
    ```typ
    #import "{import-path}": kanbun
    #kanbun(
      writing-direction: ttb,
      "自(よ)[二]リ東(とう)=京(きやう)=都(と)[一]。",
    )
    ```,
    kanbun(
      // debug: true,
      writing-direction: ttb,
      "自(よ)[二]リ東(とう)=京(きやう)=都(と)[一]。",
    ),
  ),
  (
    ```typ
    #import "{import-path}": kanbun
    #kanbun(
      writing-direction: ttb,
      max-chars-for-kaeriten-hanging-on-hyphen: 2,
      "自(よ)[二]リ東(とう)=京(きやう)=都(と)[一]。",
    )
    ```,
    kanbun(
      // debug: true,
      writing-direction: ttb,
      max-chars-for-kaeriten-hanging-on-hyphen: 2,
      "自(よ)[二]リ東(とう)=京(きやう)=都(と)[一]。",
    ),
  ),
)

`color-hypen`オプションでハイフンの色を変更できます。

#import "../texts/poems.typ": 黄鶴楼送孟浩然之廣陵
#show-compare(
  shared-caption: "〔唐〕李白《黄鶴楼送孟浩然之広陵》",
  (
    raw(
      block: true,
      lang: "typ",
      "#import \"{import-path}\": kanbun\n#kanbun(\n  color-hypen: auto, // デフォルト\n  \""
        + 黄鶴楼送孟浩然之廣陵
        + "\"\n)",
    ),
    kanbun(
      color-hypen: auto,
      黄鶴楼送孟浩然之廣陵,
    ),
  ),
  (
    raw(
      block: true,
      lang: "typ",
      "#import \"{import-path}\": kanbun\n#kanbun(\n  color-hypen: red, // 赤色\n  \"" + 黄鶴楼送孟浩然之廣陵 + "\"\n)",
    ),
    kanbun(
      color-hypen: red,
      黄鶴楼送孟浩然之廣陵,
    ),
  ),
)

`hang-kaeriten-on-connector`オプションで、ハイフンに返り点をぶら下げるかどうかを制御できます。

#show-compare(
  shared-caption: "〔唐〕李白《黄鶴楼送孟浩然之広陵》より",
  (
    raw(
      block: true,
      lang: "typ",
      "#import \"{import-path}\": kanbun\n#kanbun(\n  hang-kaeriten-on-connector: true, // デフォルト\n  \""
        + 黄鶴楼送孟浩然之廣陵
        + "\"\n)",
    ),
    kanbun(
      hang-kaeriten-on-connector: true,
      黄鶴楼送孟浩然之廣陵,
    ),
  ),
  (
    raw(
      block: true,
      lang: "typ",
      "#import \"{import-path}\": kanbun\n#kanbun(\n  hang-kaeriten-on-connector: false, // ぶら下げない\n  \""
        + 黄鶴楼送孟浩然之廣陵
        + "\"\n)",
    ),
    kanbun(
      hang-kaeriten-on-connector: false,
      黄鶴楼送孟浩然之廣陵,
    ),
  ),
)

== 句読点の位置

`punctuation-offset`オプションで、句読点の位置を微調整できます。`(dx: length, dy: length)`の辞書を指定します。

#show-compare(
  shared-caption: "〔唐〕杜甫《春望》より",
  (
    raw(
      block: true,
      lang: "typ",
      "#import \"{import-path}\": kanbun\n#kanbun(\n  punctuation-offset: (dx: -0.5em, dy: 0.2em), // デフォルト\n  \""
        + 春望
        + "\"\n)",
    ),
    kanbun(
      punctuation-offset: (dx: -0.5em, dy: 0.2em),
      春望,
    ),
  ),
  (
    raw(
      block: true,
      lang: "typ",
      "#import \"{import-path}\": kanbun\n#kanbun(\n  punctuation-offset: (dx: -0.2em, dy: 0em), // 調整\n  \""
        + 春望
        + "\"\n)",
    ),
    kanbun(
      punctuation-offset: (dx: -0.2em, dy: 0em),
      春望,
    ),
  ),
)

== 左ルビ

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

#import "../utils/display.typ": show-example

#show-example(
  "學ビテ而時ニ習フ[㆑]之ヲ、不[㆓]亦タ説バシカラ[㆒]乎？有リ[㆑]朋自リ[㆓]遠方[㆒]来タル、不[㆓]亦タ樂シカラ[㆒]乎？人不シテ[㆑]知ラ而不[㆑]慍ミ、不[㆓]亦タ君子ナラ[㆒]乎？",
  tight: true,
)

#show-example(
  "能ク以テ[二]禮=讓ヲ[一]爲（をさ）ムル[レ]国ヲ乎、何有ラン？不ンバ[レ]能ハ[下]以テ[二]禮=讓ヲ[一]爲（をさ）ムル[上レ]國ヲ、如[レ]禮ヲ何セン。",
  tight: false,
)


#show-example("其ノ人弗ル能ハ應フル也。")

