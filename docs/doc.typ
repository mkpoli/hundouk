#import "@preview/tidy:0.4.3"

#import "../src/lib.typ": render-kanbun, parse-wenyan, kanbun, group-nodes, parse-kanbun

#import "./lib.typ": doc, ruby
#let 大學章句 = read("./texts/latsgruk.txt")

#let 大學章句-sentences = 大學章句.split("。").filter(s => s.len() > 0).map(s => s + "。")

#let chars-per-page = 1000
#let (doc-pages, last-page, _last-len) = 大學章句-sentences.fold(
  ((), (), 0),
  ((pages, current, len), s) => {
    let new-len = len + s.len()
    let new-current = current + (s,)
    if new-len >= chars-per-page {
      (pages + (new-current.join(""),), (), 0)
    } else {
      (pages, new-current, new-len)
    }
  },
)
#let doc-pages = if last-page.len() > 0 {
  doc-pages + (last-page.join(""),)
} else {
  doc-pages
}

#set page(
  background: context [
    #set text(size: 25pt, fill: rgb(0%, 0%, 0%, 8%))
    #let page-number = counter(page).get().at(0)
    #box(
      width: 100%,
      kanbun(
        height: 15em,
        line-spacing: 0.25em,
        doc-pages.at(page-number - 1, default: ""),
      ),
    )
    #v(1fr)
  ],
)
#let package-info = toml("../typst.toml").package


#let subtitle-text = "以テ[二]牒(てふ)=悉(しつ)‹Typst›ヲ[一]點ジ[二]漢(かん)=文(ぶん)ニ[一]。爲スノ[二]訓(くん)=讀(どく)‹hundouk›[一]ヲ之器(うつわ)‹ツール›也。"

#show: doc.with(
  title: [#package-info.name v#package-info.version],
  subtitle: [
    #kanbun(
      // debug: true,A
      ruby-gutter: 0.1em,
      ruby-tracking: 0.01em,
      writing-direction: ltr,
      subtitle-text,
    )],
  author: [#ruby[mkpoli][まくぽり]],
)


#show "{import-path}": "@preview/" + package-info.name + ":" + package-info.version

// #group-nodes(parse-kanbun(subtitle-text))
= 概要 / Overview
このパッケージはTypstを利用して、漢文の訓点文を疑似縦書きでレンダリングを行うためのライブラリです。

具体的には、与えられたピュアテキストに特定なフォーマットで書かれた訓点情報付きの漢文テキストをパースし、得られた構造化漢文データを`grid`や`stack`などを用いることで擬似的に漢文をレンダリングするためのパッケージです。

これは、主にunt氏（\@UntPhesoca）のkanbunHTML及び陳元鎬（\@Nyoeghau）氏のLaTeX用`kanbun`パッケージから着想を得て制作されたものです。

= 使い方の例 / Usage Examples
#include "./sections/example.typ"

#include "./sections/extras.typ"

= APIリファレンス / API Reference
== 関数
#let docs = tidy.parse-module(read("../src/lib.typ"))
#tidy.show-module(docs, style: tidy.styles.default)



