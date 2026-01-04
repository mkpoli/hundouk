
#import "../utils/display.typ": show-simple
#import "../../src/lib.typ": (
  hakubun, parse-aozora, parse-kanbun, parse-wenyan, render-kanbun, serialize-kanbun, yomikudasi,
)
= その他の機能 / Other Features

== 白文抽出 / Raw Text Extraction

#show-simple(
  ```typ
  #import "{import-path}": hakubun

  #hakubun("朝ニ聞カバ[㆑]道ヲ、夕ニ死ストモ可矣。")
  ```,
  hakubun("朝ニ聞カバ[㆑]道ヲ、夕ニ死ストモ可矣。"),
)


== 読み下し / Japanese Reading

#show-simple(
  ```typ
  #import "{import-path}": yomikudasi

  #yomikudasi("知ル[㆑]之ヲ者ハ不[㆑]如カ[㆓]好ム[㆑]之ヲ者ニ[㆒]、好ム[㆑]之ヲ者ハ不[㆑]如カ[㆓]樂シム[㆑]之ヲ者ニ[㆒]。")
  ```,

  yomikudasi(
    "知ル[㆑]之ヲ者ハ不[㆑]如カ[㆓]好ム[㆑]之ヲ者ニ[㆒]、好ム[㆑]之ヲ者ハ不[㆑]如カ[㆓]樂シム[㆑]之ヲ者ニ[㆒]。",
  ),
)

== シリアライズ / Serialization

#show-simple(
  ```typ
  #import "{import-path}": parse-kanbun, serialize-kanbun

  #let original = "漢文（かんぶん）ノ[レ]例"
  #let nodes = parse-kanbun(original)
  #let serialized = serialize-kanbun(nodes)

  - Original: #original
  - Serialized: #serialized
  - Match: #strong(if original == serialized { "True" } else { "False" })
  ```,
  {
    let original = "漢文（かんぶん）ノ[レ]例"
    let nodes = parse-kanbun(original)
    let serialized = serialize-kanbun(nodes)
    [
      - Original: #original
      - Serialized: #serialized
      - Match: #strong(if original == serialized { "True" } else { "False" })
    ]
  },
)

== 青空文庫形式のパース / Parsing Aozora Bunko

青空文庫形式のテキストをパースしてレンダリングできます。

#show-simple(
  ```typ
  #import "{import-path}": parse-aozora, render-kanbun

  #render-kanbun(
    parse-aozora("吾《われ》嘗《かつ》テ終《しゅう》日《じつ》不《ず》［＃レ］食《く》ラハ、終夜《しゅうや》不《ず》［＃レ］寝《い》ネ、以《もつ》テ思《おも》フ。")
  )
  ```,
  render-kanbun(
    parse-aozora(
      "吾《われ》嘗《かつ》テ終《しゅう》日《じつ》不《ず》［＃レ］食《く》ラハ、終夜《しゅうや》不《ず》［＃レ］寝《い》ネ、以《もつ》テ思《おも》フ。",
    ),
  ),
)

#show-simple(
  ```typ
  #import "{import-path}": parse-aozora, render-kanbun
  // 竪点（ハイフン）の使用例
  #render-kanbun(
    parse-aozora("自［＃二］女王國［＃一］東度［＃レ］海千餘里。")
  )
  ```,
  render-kanbun(
    parse-aozora("自［＃二］女王國［＃一］東度［＃レ］海千餘里。"),
  ),
)

== Yhëhtozr形式のパース / Parsing Wenyan Format

Yhëhtozr体（`wenyan-book-ja`）形式のテキストをパースしてレンダリングできます。

#show-simple(
  ```typ
  #import "{import-path}": parse-wenyan, render-kanbun

  #render-kanbun(
    parse-wenyan("子曰（いわ）ク、学（まな）ビテ時（とき）ニ習（なラ）フ=之（これ）ヲ、亦悦（よろこ）バシカラズ=乎（や）0。")
  )
  ```,
  render-kanbun(
    parse-wenyan(
      "子曰（いわ）ク、学（まな）ビテ時（とき）ニ習（なラ）フ=之（これ）ヲ、亦悦（よろこ）バシカラズ=乎（や）0。",
    ),
  ),
)

