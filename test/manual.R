# 各OS固有標準フォント + なんか

require(ggplot2)
require(svglite)
require(fontregisterer)

out_dir <- tempdir()
fontlist <- get_standard_ja_fonts()
fontlist <- as.character(
  c(fontlist,
    "Noto Sans CJK JP", "Noto Serif CJK JP",
    "DejaVu Sans", "DejaVu Serif",
    "青柳隷書SIMO2_O", "F910新コミック体", "原ノ味明朝", "原ノ味角ゴシック"
    ))
if(Sys.info()["sysname"] == "Darwin"){
  fontlist <- c(fontlist, "Hiragino Maru Gothic ProN", "Hiragino Kaku Gothic StdN", "YuMincho", "YuGothic")
}
if(Sys.info()["sysname"] == "Windows"){
  fontlist <- c(fontlist, "MS Gothic", "MS Mincho", "Meiryo", "BIZ UD明朝", "BIZ UDゴシック")
}
fontlist <- unique(fontlist)


for(f in fontlist){
  par(family = f)
  plot(0, main = paste("ファミリ:", f), pch = "")
  text(-.6, label = "plain プレイン", font = 1)
  text(-.2, label = "italic 斜体", font = 2)
  text(.2, label = "bold 太字", font = 3)
  text(.6, label = "bold italic 太字斜体", font = 4)
  dev.copy(png, file = file.path(out_dir, paste0("GR-", f, ".png")))
  dev.off()
  dev.copy(png, file = file.path(out_dir, paste0("GR-", f, "-cairo.png")), type = "cairo")
  dev.copy(cairo_pdf, file = file.path(out_dir, paste0("GR-", f, ".pdf")))
  dev.off()
  dev.copy(svglite, file = file.path(out_dir, paste0("GR-", f, ".svg")))
  dev.off()

}
p <- ggplot(expand.grid(family = fontlist, face = factor(1:4, labels = c("通常", "斜体", "太字", "太字斜体"))),
       aes(x = face, y = family, family = family, fontface = as.integer(face), label = family)) + geom_text() +
  theme(text = element_text(family = get_standard_ja_fonts()[1]))
p
ggsave(filename = file.path(out_dir, "ggplot.png"), plot = p)
ggsave(filename = file.path(out_dir, "ggplot.pdf"), plot = p, device = cairo_pdf)
ggsave(filename = file.path(out_dir, "ggplotCario.png"), plot = p, type = "cairo")
ggsave(filename = file.path(out_dir, "ggplot.svg"), plot = p, device = svglite)
out_dir
