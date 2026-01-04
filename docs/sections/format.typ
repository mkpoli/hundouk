= 記述フォーマット / Representation Format <sec:format>

このパッケージでは、漢文の訓点情報を付与するために、他の類似パッケージに類似したテキスト形式を採用しています。

この形式は、以下のようなBNF記法で記述できます。

```bnf
KanbunText ::= (Element)*
Element    ::= Character | Connector | Punctuation | Newline
Character  ::= Surface (Ruby)? (Okurigana)? (Kaeriten)? (LeftRuby)? (LeftOkurigana)?
Surface    ::= <Any unicode character except special markers>
Ruby       ::= "(" <Text> ")" | "（" <Text> "）"
Okurigana  ::= <Katakana/Hiragana/ProlongedSound>+
Kaeriten   ::= "[" <Text> "]"
LeftRuby   ::= "‹" <Text> "›"
LeftOkuri  ::= "«" <Text> "»"
Connector  ::= ("=" | "―") (Kaeriten)?
Punctuation ::= "、" | "。" | "，" | "．" | ...
Newline    ::= "\n"
```

== 要素の詳細 / Element Details

- *Surface (親文字)*: 漢字などの基本となる文字です。
- *Ruby (ルビ/ふりがな)*: 親文字の直後に `(...)` または `（...）` で記述します。
- *Okurigana (送り仮名)*: 親文字（およびルビ）の直後にカタカナ（またはひらがな）を直接記述します。
- *Kaeriten (返り点)*: `[...]` で記述します。`[レ]`, `[一]`, `[二]`, `[上]`, `[下]` などが使用できます。
- *LeftRuby (左ルビ/傍注)*: `‹...›` (U+2039, U+203A) で記述します。
- *LeftOkurigana (左送り仮名)*: `«...»` (U+00AB, U+00BB) で記述します。
- *Connector (接続符/ハイフン)*: 文字と文字の間を `=` または `―` で繋ぐことで、それらを1つのグループ（熟語）として扱います。縦書きレイアウトでは、これらの文字はグループとして配置され、ハイフン部分に縦線が描画されます。返り点をハイフンに付けることも可能です（例: `=[レ]`）。

== 例 / Examples

```text
漢(かん)文(ぶん)ノ[レ]法
```
-> 「漢」にルビ「かん」、「文」にルビ「ぶん」、「ノ」は送り仮名、返り点「レ」が「法」の前に付きます（実際には「法」の後に記述されますが、「ノ」の後、「法」の前という位置関係になります）。

== 青空文庫形式 / Aozora Bunko Format

青空文庫形式のテキストデータもパース可能です。このフォーマットは、ルビや注記をテキスト形式で表現するためのデファクトスタンダードの一つです。

```bnf
AozoraText ::= (Element)*
Element    ::= Character | Connector | Punctuation | Newline
Character  ::= Surface (Ruby)? (HiddenRuby)? (Okurigana)? (Kaeriten)?
Surface    ::= <Any unicode character>
Ruby       ::= "《" <Text> "》"
HiddenRuby ::= "〈" <Text> "〉"
Okurigana  ::= <Kana>+ | "［＃（" <Text> "）］"
Kaeriten   ::= "［＃" <Text> "］"
Connector  ::= "‐" (Kaeriten)?
```

- *Ruby (ルビ)*: `《...》` で記述します。
- *HiddenRuby (非表示ルビ/再読)*: `〈...〉` で記述します。置き字の場合は空の `〈〉` を使用します。
- *Okurigana (送り仮名)*: 漢字の直後にカタカナ・ひらがなを記述するか、`［＃（...）］` で記述します。
- *Kaeriten (返り点)*: `［＃...］` で記述します（例: `［＃レ］`）。
- *Connector (竪点)*: `‐` (U+2010 HYPHEN) で記述します。

== Yhëhtozr形式 / Wenyan Format

Yhëhtozr体（`wenyan-book-ja`）で使用される形式もサポートしています。

```bnf
WenyanText ::= (Element)*
Element    ::= Character | Connector | Punctuation | Newline
Character  ::= Surface (Ruby)? (Okurigana)? (Kaeriten)? (LeftRuby)?
Surface    ::= <Any unicode character>
Ruby       ::= "（" <Text> "）" | <Hiragana>+
Okurigana  ::= <Katakana>+
Kaeriten   ::= <Digit>
LeftRuby   ::= "〔" <Text> "〕"
Connector  ::= "="
```

- *Ruby (ルビ)*: `（...）` または直後のひらがな・長音符で記述します。
- *Okurigana (送り仮名)*: 直後のカタカナ・長音符で記述します。
- *Kaeriten (返り点)*: 直後の数字で記述します（`0`=レ, `1`=一, `2`=二...）。
- *LeftRuby (左ルビ/傍注)*: `〔...〕` で記述します。


