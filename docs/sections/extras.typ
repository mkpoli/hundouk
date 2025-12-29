
#import "../utils/display.typ": show-simple
#import "../../src/lib.typ": yomikudasi, hakubun
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

  yomikudasi("知ル[㆑]之ヲ者ハ不[㆑]如カ[㆓]好ム[㆑]之ヲ者ニ[㆒]、好ム[㆑]之ヲ者ハ不[㆑]如カ[㆓]樂シム[㆑]之ヲ者ニ[㆒]。"),
)
