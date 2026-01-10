#import "../src/lib.typ": kanbun
#set page(
  width: 40em,
  height: auto,
)
#set text(font: "Harano Aji Mincho", lang: "ja")
#show heading: set align(center)
#show heading: set block(spacing: 3em)
= 〔明〕陳第《毛詩古音考・序》

#set text(2em)
#figure(
  kanbun(
    "蓋(けだ)シ時ニ有リ[二]古=今[一]，地ニ有リ[二]南=北[一]；字ニ有リ[二]更(かう)=革（かく)[一]，音ニ有リ[二]轉=移[一]，亦タ勢(いきほ)ヒノ所ナリ[二]必ズ至ル[一]。",
    use-unicode-kanbun: true, // Set to false to use normalized CJK characters (e.g. レ) instead of Kanbun Block characters (e.g. ㆑),
    tight: true, // Default to true, tight layout is without inter-character space (ベタ組) and when false (non-tight layout) is with fixed inter-character space (アキ組),
    height: 10em, // For `ttb` writing-direction it's the height limit for point to break line automatically, for `ltr` it's the width
    writing-direction: ttb, // Default to `ttb`, can be `ttb` (縦組) or `ltr` (横組),
  ),
)
