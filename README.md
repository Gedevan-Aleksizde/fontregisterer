# Cross-platform Automatic Font Registerer For R Graphics

全てのシステムフォントをRグラフィックスに登録するだけのパッケージ (クロスプラットフォーム)

**お使いのOSがLINUXの場合は不要です**

**You don't have to use this package if your operating system is LINUX**

## Installation

run the following command in R

```r
remotes::install_github("Gedevan-Aleksizde/fontregisterer", repos = NULL)
```

This package depends on [`systemfonts`](https://cran.r-project.org/web/packages/systemfonts/index.html).


## Usage

This package registers all of your system fonts automatically when loaded. this procedure is executed by `widowsFonts()` (when Windows OS) or `quartzFonts()` (when Mac OS).

```r
library(fontregisterer)
```

You can also reload by executing `register_all_fonts()`.

You can check the list of loaded fonts by `windowsFonts()` or `quartzFonts()`, or `systemfonts::system_fonts()$family` if LINUX.

You can specify font family name to charts drawn by both `graphics` and `ggplot2` based packages.


ALL YOUR FONT ARE BELONG TO YOU...

## インストール方法

R で以下を実行してください

```r
remotes::install_github("Gedevan-Aleksizde/fontregisterer", repos = NULL, type = "source")
```

このパッケージは [`systemfonts`](https://cran.r-project.org/web/packages/systemfonts/index.html) に依存しています.

## 使い方

```r
library(fontregisterer)
```

で読み込んだ時点で作動します. Windows なら `windowsFonts()`, Mac なら `quartzFonts()` を使用してシステムフォントを全て登録します. やり直したかったら `register_all_fonts()` を実行してください (例えば使用中に新しくフォントをインストールしたなどの場合).

登録されたフォントファミリを確認したい場合は `windowsFonts()` または  `quartzFonts()` を実行してください. LINUX の場合は `systemfonts::system_fonts()$family` で確認できます.

登録されたフォントファミリ名は標準グラフィックにも `ggplot2` にも指定可能です.

例えば, Windows (8以降) ならば `"Yu Mincho"` (游明朝), `Yu Gothic` (游ゴシック) などを, Mac なら `"Hiragino Mincho ProN"` (ヒラギノ明朝ProN), `"Hiragino Sans"` (ヒラギノ角ゴシック) などを指定可能です.

グラフのフォント指定は例えば標準グラフィックスなら

```r
par(family = "Yu Gothic")
plot(0, 0)
text(0, 0, "日本語表示で広がるRの世界")
```

`ggplot2` なら

```r
require(ggplot2)
ggplot(data.frame(x = 0), aes(x = 0, y = 0, label = "日本語表示で広がるRの世界")) +
  geom_point(family = "Yu Gothic") +
  labs(x = "X軸ラベル", y = "Y軸ラベル", title = "タイトル") +
  theme(text = element_text(family = "Yu Gothic"))
```

詳しくは以下を参考にしてください.

https://ill-identified.hatenablog.com/entry/2020/10/03/200618

Japan.R 2020 で紹介しました.

https://speakerdeck.com/ktgrstsh/display-cjk-font-in-any-gpraphic-device-and-platform-2020

ALL YOUR FONT ARE BELONG TO YOU...
