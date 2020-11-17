# 各OS固有標準フォント + なんか

require(ggplot2)
require(svglite)
require(fontregisterer)
require(systemfonts)

out_dir <- tempdir()
fontlist <- data.frame(family = get_standard_ja_fonts())
fontlist$name <- fontlist$family
fontlist <- rbind(
  fontlist,
  data.frame(family = c(
    "Noto Sans CJK JP", "Noto Serif CJK JP",
    "DejaVu Sans", "DejaVu Serif",
    "青柳隷書SIMO2_O", "F910新コミック体", "原ノ味明朝", "原ノ味角ゴシック"
    ), name = NA)
)
fontlist$name <- with(fontlist, ifelse(is.na(name), family, name))
if(Sys.info()["sysname"] == "Darwin"){
  fontlist <- rbind(
    fontlist,
    data.frame(
      family = c("Hiragino Maru Gothic ProN", "Hiragino Kaku Gothic StdN", "YuMincho", "YuGothic"),
      name = c("ヒラギノ丸ゴProN", "ヒラギノ角ゴStdN", "游明朝", "游ゴシック")
      )
    )
}
if(Sys.info()["sysname"] == "Windows"){
  fontlist <- rbind(
    fontlist,
    data.frame(
      family = c("MS Gothic", "MS PGothic", "MS Mincho", "MS PMincho", "Meiryo", "BIZ UDMincho", "BIZ UDGothic"),
      name = c("MS ゴシック", "MS Pゴシック", "MS 明朝", "MS P明朝", "メイリオ", "BIZ UD明朝", "BIZ UDゴシック")
      )
    )
  fontlist["F910新コミック体" == fontlist$family, ]$family <- "F910-Shin-comic-tai"
  fontlist["Yu Gothic" == fontlist$family, ]$name <- "游ゴシック"
  fontlist["Yu Mincho" == fontlist$family, ]$name <- "游明朝"
  fontlist["青柳隷書SIMO2_O" == fontlist$family, ]$family <- "aoyagireisyo2"
  fontlist["原ノ味角ゴシック" == fontlist$family, ]$family <- "Harano Aji Gothic"
  fontlist["原ノ味明朝" == fontlist$family, ]$family <- "Harano Aji Mincho"
}

fontlist <- unique(fontlist)
fontlist


for(i in 1:NROW(fontlist)){
  f <- fontlist$family[i]
  n <- fontlist$name[i]
  par(family = f)
  plot(0, main = paste("ファミリ:", n), pch = "")
  text(-.6, label = "plain プレイン", font = 1)
  text(-.2, label = "bold 太字", font = 2)
  text(.2, label = "itacli 斜体", font = 3)
  text(.6, label = "bold italic 太字斜体", font = 4)
  dev.copy(png, file = file.path(out_dir, paste0("GR-", n, ".png")))
  dev.off()
  dev.copy(png, file = file.path(out_dir, paste0("GR-", n, "-cairo.png")), type = "cairo")
  dev.copy(cairo_pdf, file = file.path(out_dir, paste0("GR-", n, ".pdf")), )
  dev.off()
  dev.copy(svglite, file = file.path(out_dir, paste0("GR-", n, ".svg")))
  dev.off()
}
for(i in 1:NROW(fontlist)) dev.off()
dev.off()
tmp <- fontlist
tmp$face <- 2
fontlist$face <- 1
for(i in 2:4){
  tmp$face <- i
  fontlist <- rbind(fontlist, tmp)
}
fontlist$face <- with(fontlist, factor(face, labels = c("通常", "太字", "斜体", "太字斜体")))

p <- ggplot(fontlist,
            aes(x = face, y = family, family = family, fontface = as.integer(face), label = name)) + geom_text() +
  theme(text = element_text(family = get_standard_ja_fonts()[1]))
p
ggsave(filename = file.path(out_dir, "ggplot.png"), plot = p)
ggsave(filename = file.path(out_dir, "ggplot.pdf"), plot = p, device = cairo_pdf)
ggsave(filename = file.path(out_dir, "ggplotCario.png"), plot = p, type = "cairo")
ggsave(filename = file.path(out_dir, "ggplot.svg"), plot = p, device = svglite)
out_dir
