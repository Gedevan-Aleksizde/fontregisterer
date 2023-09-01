#' get font names corresponding to four style names for a font family/フォントファミリから4種類の書体に対応するフォント名を取り出す
#' @description `systemfonts::system_fonts()` などの結果から4書体のフォントを取得する. ただしうまくいくとは限らない.
#' @param data: `data.frame` alike, output of font list from `systemfonts::system_fonts()` or its subset, which includes six columns: `name`, `family`, `style`, `weight`, `width`, and `italic`/ `data.frame` 相当のオブジェクトで, `systemfonts::system_fonts()` のから特定のファミリだけ取り出したもので, `name`, `family`, `style`, `weight`, `width`, `italic` 列を持つもの.
#' @return  character vector of length 4: It's elements are names of plain, bold, italic, and bold italic font./長さ4の文字列ベクトル. 要素は順に標準, ボールド, イタリック, ボールドイタリック体のpostscript名.
#' @export
#'
get_styles <- function(data){
  styles <- c("plain", "normal", "regular", "medium", "bold", "italic", "bolditalic", "w3")
  styles_plain <- c("plain", "normal", "regular", "medium", "w3")
  data$style <- with(data, factor(tolower(style), styles))
  plain <- subset(data, width == "normal" & weight == "normal")
  if(NROW(plain) > 0){
    plain <- plain
  } else {
    plain <- data
  }
  if(NROW(subset(plain, style %in% styles_plain)) > 0){
    plain <- plain[order(plain$style), ]$name[1]
  } else {
    plain <- plain$name[1]
  }
  bold <- subset(data, style == "bold")
  if(NROW(bold) > 0){
    bold <- bold$name[1]
  } else {
    bold <- plain
  }
  italic <- subset(data, style == "italic" | italic)
  if(NROW(italic) > 0){
    italic <- italic$name[1]
  } else {
    italic <- plain
  }
  bi <- subset(data, style == "bold italic")
  if(NROW(bi) > 0){
    bi <- bi$name[1]
  } else {
    bi <- italic
  }
  return(c(plain = plain, bold = bold, italic = italic, bolditalic = bi))
}
