# Cross-platform Auto Font Registerer For R Graphics
全てのシステムフォントをRグラフィックスに登録するだけのパッケージ (クロスプラットフォーム)

## インストール方法

R上で

```r
remotes::install_github("Gedevan-Aleksizde/fontregisterer", repos = NULL, type = "source")
```

を入力するか, `git clone` してから `setwd(...); install.packages("./", repos = NULL)`

## 使い方

```r
library(fontregisterer)
```

で読み込んだ時点で作動する. やり直したかったら `register_all_fonts()` を実行する.

登録されたフォントファミリを確認したい場合は `windowsFonts()` または  `quartzFonts()` を実行する.

登録されたフォントファミリ名は標準グラフィックにも `ggplot2` にも指定可能.
