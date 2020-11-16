# fontregisterer 0.2

* (EN)
  + Add `set_ja_font_standard()`. This function changes default `ggplot2` font family and change the font families which are refered by `sans` and `serif` for easier R Graphics settings.
  + Rename `get_standard_font()` to `get_standard_ja_font()`.
  + Update the documentation.
    - loacalization for Japanese. run `Sys.setenv(LANG="ja_JP")`.
  + Refactoring
    - drop `tidyverse` from the Imports.
* (JA)
  + Rグラフィックのフォント登録をまとめて実行するために, Windows/Mac の `sans`/`serif` が参照するフォントを変更し, `ggplot2` のデフォルト設定を変える `set_ja_font_standard()` を追加.
  + `get_standard_font()` を `get_standard_ja_font()` に改名.
  + ドキュメントの整理
    - メッセージの日本語ローカライズ. `Sys.setenv(LANG="ja_JP")` で表示
  + リファクタリング
    - Imports から `tidyverse` を除外

# fontregisterer 0.1.1

* modify initializing message

# fontregisterer 0.1.0

* First Release
