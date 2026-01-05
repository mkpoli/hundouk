#import "@preview/touying:0.6.1": *
#import themes.university: *
#import "@preview/cetz:0.3.2"
#import "@preview/fletcher:0.5.4" as fletcher: edge, node
#import "@preview/numbly:0.1.0": numbly
#import "@preview/rubby:0.10.2": get-ruby

// Import local package if available, otherwise assume it will be available in context
// For this presentation, we will simulate the examples or assume the package is at the root
// Since we are in the repo, we can import from src
#import "../src/lib.typ": *
#let kundoku = kanbun

#let ruby = get-ruby()

#set text(lang: "ja")


#let cetz-canvas = touying-reducer.with(reduce: cetz.canvas, cover: cetz.draw.hide.with(bounds: true))
#let fletcher-diagram = touying-reducer.with(reduce: fletcher.diagram, cover: fletcher.hide)

#set text(font: ("遍玨體P1", "遍玨體P2"))
// #set par(
//   first-line-indent: (
//     all: true,
//     amount: 1em,
//   ),
// )

#show: university-theme.with(
  aspect-ratio: "16-9",
  config-info(
    title: [漢文組版エンジン\ hundouk の設計と実装],
    subtitle: [Typstで美しい漢文を目指して],
    // author: [mkpoli],
    date: datetime.today(),
  ),
  config-page(margin: 4em), // Add margin,
)

#set heading(numbering: numbly("{1}.", default: "1.1"))

#title-slide()

// == 目次 <touying:hidden>

// #components.adaptive-columns(outline(title: none, indent: 1em))

#set text(27pt)
#show link: set text(25pt, fill: blue)
#show link: underline

#let eg(it) = {
  set text(fill: gradient.linear(angle: 45deg, red, blue))
  it
}

// #set par(leading: 0.5em)

= 序論 (Introduction)

== 漢文とは？ (What is Kanbun?)

#slide[
  #set align(center + horizon)
  　*#ruby[かんぶん][漢文]* (Kanbun) とは漢籍などを中心に使われてきた\
  中国の古典文またはそれに倣った文体である。

  #pause

  #eg[
    子曰：「學而時習之，不亦說乎？有朋自遠方來，不亦樂乎？人不知而不慍，不亦君子乎？」
  ]
]

#slide[
  #set align(center + horizon)
  　漢文が書かれた言語は書字言語であり、#ruby[Classical Chinese][古典中国語]または#ruby[Literacy Chinese][文語体中国語]と呼ばれる。

  #eg[
    子曰：「學而時習之，不亦說乎？有朋自遠方來，不亦樂乎？人不知而不慍，不亦君子乎？」
  ]
]

#slide[
  #set align(center + horizon)
  　古典中国語は紀元前から近代まで主要な書記言語として利用され、現代でも一部の分野で利用され、また教育の文脈では未だに広く行われている。

  　数千年來、漢字文化圏への伝播は漢字という文字に限らず、漢文という言語も重要な役割を果たし、\ 現代諸言語には大きな影響を与えている。

  #eg[
    子曰：「學而時習之，不亦說乎？有朋自遠方來，不亦樂乎？人不知而不慍，不亦君子乎？」
  ]
]

#slide[
  #set align(center + horizon)
  　古典中国語は無から生まれたわけではなく、\ 上代中国語という口語がベースであり、口語を精緻化して文字に書き、また後世の人は言語が変わっても極力古い文体を真似るように使われてきたの結果、そうやって緩やかに変化し、生まれたのが\ 古典中国語である。
]


#slide[
  #set align(center + horizon)
  　それでは中国語歴史音韻論の学者たちがあらゆる史的証拠から、再建した音韻体系モデルによる、\ 2500年前の中国語の発音を聴いてみましょう。

  #link("https://www.bilibili.com/video/BV1Zb411a7BE/")

  #eg[
    子曰：「學而時習之，不亦說乎？有朋自遠方來，不亦樂乎？人不知而不慍，不亦君子乎？」
  ]
]

#slide[
  #set align(center + horizon)
  　日本では、古典中国語によって書かれた漢文を解読するために開発され、受け継がれてきた「漢文訓読」（Kanbun-Kundoku）と呼ばれる技術がある。

  　何も付けられていない漢文の白文に、訓点と呼ばれる音や意味、読む順番などを記述する特殊な記号体系を用いることで、漢文訓読体と呼ばれる特殊な日本語に機械的に翻訳することができる。
]
#slide[
  #set align(center + horizon)
  今までできた概念を整理してみましょう。
  #[
    #set align(left)
    / *古典中国語*: 古代中国の文語体
    / *漢籍*: 中国の古典書籍
    / *漢文*: 古典中国語によって書かれた文章
    / *白文*: 記号が付けられていない漢文
    / *漢文訓読*: 古典中国語を日本語で読み解く方法
    / *訓点*: 漢文訓読のめに漢字に付与する記号
  ]
]


== 訓点漢文の組版

#slide[
  #set align(center + horizon)
  　訓点漢文とは訓点を漢字に付与したものである。
  #figure(
    caption: [「#ruby[しのばずのいけ][不忍池]」（東京都台東区の地名）],
    kanbun("不(ず)ノ[レ]忍(しの)バ池(いけ)"),
    kind: "example",
    supplement: [例],
  )
]

#show figure.where(kind: "example"): set text(16pt)

#slide[
  #figure(
    kundoku(
      tight: false,
      use-unicode-kanbun: false,
      "渭城ノ朝雨浥(うるお)シ[二]輕塵ヲ[一]
    客舍青青柳色新タナリ
    勸ム[レ]君ニ更ニ盡セ一杯ノ酒
    西ノカタ出ヅレバ[二]陽關ヲ[一]無[二]カラン故人[一]",
    ),
    kind: "example",
    supplement: [例],
    caption: [〔唐〕王維『送元二使安西』],
  )
]

#let 登鸛雀樓 = "白日依リテ[レ]山ニ盡キ，黃河入リテ[レ]海ニ流ル。欲シ[二]窮メント[一]千里ノ目ヲ，更ニ上ル一層ノ樓。"
#let 靜夜思 = "床前看[二]ル月光ヲ[一]，\n 疑ウラクハ[二]是レ地上ノ霜カト[一]。\n 舉[レ]ゲテ頭ヲ望ム[二]山月ヲ[一]，\n  低[レ]レテ頭ヲ思フ[二]故鄕ヲ[一]。"

#slide[
  #grid(
    columns: (1fr, 1fr),
    gutter: 1em,
    figure(
      caption: "ベタ組〔唐〕王之渙『登鸛鵲樓』",
      kanbun(
        height: 10em,
        登鸛雀樓,
        use-unicode-kanbun: false,
      ),
      kind: "example",
      supplement: [例],
    ),
    figure(
      caption: "アキ組〔唐〕王之渙『登鸛鵲樓』",
      kanbun(
        height: 12em,
        登鸛雀樓,
        tight: false,
        use-unicode-kanbun: false,
      ),
      kind: "example",
      supplement: [例],
    ),
  )
]

#slide[
  #grid(
    columns: (1fr, 1fr),
    gutter: 1em,
    figure(
      caption: "縦組〔唐〕李白『靜夜思』",
      kanbun(
        height: 12em,
        靜夜思,
        tight: false,
        use-unicode-kanbun: false,
      ),
      kind: "example",
      supplement: [例],
    ),
    figure(
      caption: "横組〔唐〕李白『靜夜思』",
      kanbun(
        靜夜思,
        writing-direction: ltr,
        use-unicode-kanbun: false,
      ),
      kind: "example",
      supplement: [例],
    ),
  )
]


== なぜTypstで漢文なのか？

#show heading.where(level: 3): set block(spacing: 1em)

#slide[
  #set align(center + horizon)
  === なぜTypst？

  まず、Typstを使いたい。

  #link("https://typst.app/")
]

#show list: set align(left)
#slide[
  #set align(center + horizon)
  === 別のツールは？
  - Word / 一太郎
  - Web (HTML/CSS)
  - LaTeX: kanbun (legacy) / gckanbun / sfkanbun / kanbun
  - C / ...
  - 専用ツール
]

#slide[
  === Typstの問題
  - CJKサポート
  - 書字方向
]


= 設計と実装 (How)

== hundoukとは？

#slide[
  　*hundouk* (訓読) は、Typst上で訓点漢文を美しく組版するためのパッケージである。

  　*hundouk*という名前は、約1000年前の南北朝～隋代の中国語で「訓讀」を読んだ再構音に由来し、#link("https://phesoca.com/tupa/")[[TUPA (切韻拼音)]]と呼ばれる中古音転写体系を用いた。
]
== 設計思想

#slide[
  目指したのは *「書きやすさ」*と*「美しさ」*の両立です。

  ```typst
  #kanbun("子曰ク，學ビテ而時ニ習フ[二]之ヲ[一]，不[三]亦說(よろこ)バシカラ[二]乎(ずや)[一]。有リ[レ]朋自リ[二]遠方[一]來タル，不[三]亦樂(たの)シカラ[二]乎(ずや)[一]。人不[レ]知ラズシテ而不[レ]慍(うら)ミズ，不[三]亦君子ナラ[二]乎(ずや)[一]。")
  ```
]
#slide[
  #figure(
    kanbun(
      height: 10em,
      use-unicode-kanbun: false,
      "子曰ク，學ビテ而時ニ習フ[二]之ヲ[一]，不[三]亦說(よろこ)バシカラ[二]乎(ずや)[一]。有リ[レ]朋自リ[二]遠方[一]來タル，不[三]亦樂(たの)シカラ[二]乎(ずや)[一]。人不[レ]知ラズシテ而不[レ]慍(うら)ミズ，不[三]亦君子ナラ[二]乎(ずや)[一]。",
    ),
  )
]

== 実装の詳細：グリッドレイアウト

#slide[
  #set align(horizon)
  　Typst標準の `grid()` 関数と `stack()` 関数を組み合わせて、擬似的な縦書きを実現している

  　入力されたテキストを解析し、構造化データに\ 変換し、それをベースにレンダリングを行う。
]


#slide[
  #set align(horizon)
  構造を見てみよう。
  #let subtitle-text = "以テ[二]牒(てふ)=悉(しつ)‹Typst›ヲ[一]點ジ[二]漢(かん)=文(ぶん)ニ[一]。爲スノ[二]訓(くん)=讀(どく)‹hundouk›[一]ヲ之器(うつわ)‹ツール›也。"

  #kanbun(
    // debug: true,A
    ruby-gutter: 0.1em,
    ruby-tracking: 0.01em,
    writing-direction: ltr,

    subtitle-text,
  )

  #kanbun(
    // debug: true,A
    ruby-gutter: 0.1em,
    ruby-tracking: 0.01em,
    writing-direction: ltr,
    debug: true,
    subtitle-text,
  )
]

= 実際の挙動 (Demo)


== アキ組とベタ組

字間設定も可能です。

#pause

- *ベタ組*: 漢字の間に余白を置かない組版方法
- *アキ組*: 固定の字間余白を置く組版方法

`hundouk` はパラメータ調整でこれらの

== 組版例


#slide[

  #set align(center + horizon)
  "不(ず)ノ[レ]忍(しの)バ池(いけ)"
  #figure(
    caption: [「#ruby[しのばずのいけ][不忍池]」（東京都台東区の地名）],
    kanbun("不(ず)ノ[レ]忍(しの)バ池(いけ)"),
    kind: "example",
    supplement: [例],
  )
]
#slide[
  #set align(center + horizon)
  "不(ず)ノ[レ]忍(しの)バ池(いけ)"
  #figure(
    caption: [「#ruby[しのばずのいけ][不忍池]」（東京都台東区の地名）],
    kanbun("不(ず)ノ[レ]忍(しの)バ池(いけ)", debug: true),
    kind: "example",
    supplement: [例],
  )
]

#show figure.where(kind: "example"): set text(16pt)

#slide[
  "渭城ノ朝雨浥(うるお)シ[二]輕塵ヲ[一]
  客舍青青柳色新タナリ
  勸ム[レ]君ニ更ニ盡セ一杯ノ酒
  西ノカタ出ヅレバ[二]陽關ヲ[一]無[二]カラン故人[一]"
]

#slide[
  #figure(
    kundoku(
      tight: false,
      use-unicode-kanbun: false,
      "渭城ノ朝雨浥(うるお)シ[二]輕塵ヲ[一]
    客舍青青柳色新タナリ
    勸ム[レ]君ニ更ニ盡セ一杯ノ酒
    西ノカタ出ヅレバ[二]陽關ヲ[一]無[二]カラン故人[一]",
    ),
    kind: "example",
    supplement: [例],
    caption: [〔唐〕王維『送元二使安西』],
  )
]
#slide[
  #figure(
    kundoku(
      tight: false,
      use-unicode-kanbun: false,
      "渭城ノ朝雨浥(うるお)シ[二]輕塵ヲ[一]
    客舍青青柳色新タナリ
    勸ム[レ]君ニ更ニ盡セ一杯ノ酒
    西ノカタ出ヅレバ[二]陽關ヲ[一]無[二]カラン故人[一]",
      debug: true,
    ),
    kind: "example",
    supplement: [例],
    caption: [〔唐〕王維『送元二使安西』],
  )
]

#let 登鸛雀樓 = "白日依リテ[レ]山ニ盡キ，黃河入リテ[レ]海ニ流ル。欲シ[二]窮メント[一]千里ノ目ヲ，更ニ上ル一層ノ樓。"
#let 靜夜思 = "床前看[二]ル月光ヲ[一]，\n 疑ウラクハ[二]是レ地上ノ霜カト[一]。\n 舉[レ]ゲテ頭ヲ望ム[二]山月ヲ[一]，\n  低[レ]レテ頭ヲ思フ[二]故鄕ヲ[一]。"

#slide[
  "#登鸛雀樓"
]

#slide[
  #grid(
    columns: (1fr, 1fr),
    gutter: 1em,
    figure(
      caption: "ベタ組〔唐〕王之渙『登鸛鵲樓』",
      kanbun(
        height: 10em,
        登鸛雀樓,
        use-unicode-kanbun: false,
      ),
      kind: "example",
      supplement: [例],
    ),
    figure(
      caption: "アキ組〔唐〕王之渙『登鸛鵲樓』",
      kanbun(
        height: 12em,
        登鸛雀樓,
        tight: false,
        use-unicode-kanbun: false,
      ),
      kind: "example",
      supplement: [例],
    ),
  )
]

#slide[
  #grid(
    columns: (1fr, 1fr),
    gutter: 1em,
    figure(
      caption: "ベタ組〔唐〕王之渙『登鸛鵲樓』",
      kanbun(
        height: 10em,
        登鸛雀樓,
        use-unicode-kanbun: false,
        debug: true,
      ),
      kind: "example",
      supplement: [例],
    ),
    figure(
      caption: "アキ組〔唐〕王之渙『登鸛鵲樓』",
      kanbun(
        height: 12em,
        登鸛雀樓,
        tight: false,
        use-unicode-kanbun: false,
        debug: true,
      ),
      kind: "example",
      supplement: [例],
    ),
  )
]

#slide[
  "#靜夜思"
]
#slide[
  #grid(
    columns: (1fr, 1fr),
    gutter: 1em,
    figure(
      caption: "縦組〔唐〕李白『靜夜思』",
      kanbun(
        height: 12em,
        靜夜思,
        tight: false,
        use-unicode-kanbun: false,
        debug: true,
      ),
      kind: "example",
      supplement: [例],
    ),
    figure(
      caption: "横組〔唐〕李白『靜夜思』",
      kanbun(
        靜夜思,
        writing-direction: ltr,
        use-unicode-kanbun: false,
        debug: true,
      ),
      kind: "example",
      supplement: [例],
    ),
  )
]


= 今後の展望 (Future)
#slide[
  #set align(horizon)
  / *複雑なレイアウト対応*: 細かい位置調整、文字配置
  / *要件の標準化*: #link("https://github.com/mkpoli/kanbun-req")[`kanbun-req`] プロジェクトの推進
  / *パッケージ化*: Typst Universeへの登録
]


= 参考文献 (References)

== 詳細情報 (More Details)

本スライドの詳細は、以下のリポジトリ内のドキュメントを参照してください。

- *README.md*
  - インストール手順、フォントダウンロード、基本的な使い方
- *article/Typstで漢文組版してみた件.md*
  - 開発の動機、既存ツールとの比較、実装の詳細解説

== Community

#slide[
  #set align(center + horizon)
  *「くみはんクラブ」* (Typesetting Club)

  Typstをはじめとする組版技術について語り合うDiscordコミュニティです。

  #link("https://discord.gg/dHRaAsBeRY")
]

#slide[
  #align(center + horizon)[
    Thank you for listening!

    GitHub: #link("https://github.com/mkpoli/hundouk")
  ]
]

