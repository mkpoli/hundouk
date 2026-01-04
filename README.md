# hundouk

漢文訓読レンダリングツール。

`hundouk` (訓讀) is a [Typst](https://typst.app) package for rendering _Kanbun Kundoku_ (漢文訓読) texts, by which Classical Chinese texts are rendered with annotations to be translated mechanically into Classical Japanese, which is still used in modern Japanese education.

## Usage / 使い方

```typst
#import "@local/hundouk:0.1.0": kanbun

#kanbun(
  "蓋シ時ニ有リ[二]古=今[一]，地ニ有リ[二]南=北[一]；字ニ有リ[二]更=革[一]，音ニ有リ[二]轉=移[一]，亦タ勢ヒノ所[二]必ズ至ル[一]ナリ。",
  use-unicode-kanbun: true, // Set to false to use normalized CJK characters (e.g. レ) instead of Kanbun Block characters (e.g. ㆑),
  tight: true, // Default to true, tight layout is without inter-character space (ベタ組) and when false (non-tight layout) is with fixed inter-character space (アキ組),
  height: 10em, // For `ttb` writing-direction it's the height limit for point to break line automatically, for `ltr` it's the width
  writing-direction: ttb, // Default to `ttb`, can be `ttb` (縦組) or `ltr` (横組),
)
```

## What is hundouk? / 名称由来

`hundouk` comes from the Middle Chinese reconstruction of the character "訓讀" (訓読 Kundoku) written in [TUPA (切韻拼音)](https://phesoca.com/tupa/) .

## References / 参照

- 漢文HTML https://phesoca.com/kanbun-html/
- The `kanbun` package
    - https://github.com/yuanhao-chen-nyoeghau/kanbun
    - https://ctan.org/pkg/kanbun

## License / ライセンス

[MIT License](LICENSE) (c) 2025 mkpoli
