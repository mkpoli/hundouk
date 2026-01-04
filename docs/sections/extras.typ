
#import "../utils/display.typ": show-simple
#import "../../src/lib.typ": hakubun, parse-kanbun, serialize-kanbun, yomikudasi
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
