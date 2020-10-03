# Cross-platform Auto Font Registerer For R Graphics

全てのシステムフォントをRグラフィックスに登録するだけのパッケージ (クロスプラットフォーム)

## Installation

run the following command in R

```r
remotes::install_github("Gedevan-Aleksizde/fontregisterer", repos = NULL, type = "source")
```

## Usage

This package registers the system font automatically when loaded

```r
library(fontregisterer)
```

You can also reload by executing `register_all_fonts()`.

You can check the list of loaded fonts by `windowsFonts()` or `quartzFonts()`.

You can specify font family name to standard `graphics` and `ggplot2`


ALL YOUR FONTS ARE BELONG TO YOU...

## インストール方法

R で以下を実行する

```r
remotes::install_github("Gedevan-Aleksizde/fontregisterer", repos = NULL, type = "source")
```

## 使い方

```r
library(fontregisterer)
```

で読み込んだ時点で作動する. やり直したかったら `register_all_fonts()` を実行する.

登録されたフォントファミリを確認したい場合は `windowsFonts()` または  `quartzFonts()` を実行する.

登録されたフォントファミリ名は標準グラフィックにも `ggplot2` にも指定可能.

ALL YOUR FONTS ARE BELONG TO YOU...
