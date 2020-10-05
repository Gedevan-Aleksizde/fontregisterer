# Cross-platform Auto Font Registerer For R Graphics

全てのシステムフォントをRグラフィックスに登録するだけのパッケージ (クロスプラットフォーム)

**お使いのOSがLINUXの場合は不要です**

**You don't have to use this package if your OS is LINUX**

## Installation

run the following command in R

```r
remotes::install_github("Gedevan-Aleksizde/fontregisterer", repos = NULL, type = "source")
```

## Usage

This package registers all of your system fonts automatically when loaded. this procedure is executed by `widowsFonts()` (when Windows OS) or `quartzFonts()` (when Mac OS).

```r
library(fontregisterer)
```

You can also reload by executing `register_all_fonts()`.

You can check the list of loaded fonts by `windowsFonts()` or `quartzFonts()`.

You can specify font family name to standard `graphics` and `ggplot2`


ALL YOUR FONT ARE BELONG TO YOU...

## インストール方法

R で以下を実行する

```r
remotes::install_github("Gedevan-Aleksizde/fontregisterer", repos = NULL, type = "source")
```

## 使い方

```r
library(fontregisterer)
```

で読み込んだ時点で作動する. Windows なら `windowsFonts()`, Mac なら `quartzFonts()` を使用してシステムフォントを全て登録する. やり直したかったら `register_all_fonts()` を実行する.

登録されたフォントファミリを確認したい場合は `windowsFonts()` または  `quartzFonts()` を実行する.

登録されたフォントファミリ名は標準グラフィックにも `ggplot2` にも指定可能.

例えば, Windowsならば `"Yu Mincho"` (游明朝), `Yu Gothic` (游ゴシック) などを, Mac なら `"Hiagino Mincho ProN"` (ヒラギノ明朝ProN), `"Hiragino Sans"` (ヒラギノ角ゴシック) などを指定可能.

グラフのフォント指定は例えば標準グラフィックスなら

```r
par(family = "Yu Gothic")
plot(0, 0)
text(0, 0, "日本語表示で広がるWindowsの世界")
```

`ggplot2` なら

```r
require(ggplot2)
ggplot(data.frame(x = 0), aes(x = 0, y = 0, label = "日本語表示で広がるWindowsの世界")) +
  geom_point() + theme(text = element_text(family = "Yu Gothic"))
```

詳しくは以下を参考にしてください

https://ill-identified.hatenablog.com/entry/2020/10/03/200618

ALL YOUR FONT ARE BELONG TO YOU...
