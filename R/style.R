#' get font names corresponding to four style names for a font family/フォントファミリから4種類の書体に対応するフォント名を取り出す
#' @description `systemfonts::system_fonts()` などの結果から4書体のフォントを取得する. ただしうまくいくとは限らない.
#' @param data: `data.frame` alike, output of font list from `systemfonts::system_fonts()` or its subset, which includes six columns: `name`, `family`, `style`, `weight`, `width`, and `italic`/ `data.frame` 相当のオブジェクトで, `systemfonts::system_fonts()` のから特定のファミリだけ取り出したもので, `name`, `family`, `style`, `weight`, `width`, `italic` 列を持つもの.
#' @return  character vector of length 4: It's elements are names of plain, bold, italic, and bold italic font./長さ4の文字列ベクトル. 要素は順に標準, ボールド, イタリック, ボールドイタリック体のpostscript名.
#' @export
get_styles <- function(data){
  data$style <- with(data, factor(tolower(style), c("normal", "regular", "medium", "bold italic", "W3")))
  normal <- dplyr::filter(data, width == "normal", weight == "normal")
  if(NROW(normal) > 0){
    normal <- normal
  } else {
    normal <- data
  }
  if(NROW(dplyr::filter(normal, style %in% c("regular", "normal", "medium", "bold italic", "W3"))) > 0){
    normal <- dplyr::arrange(normal, style)$name[1]
  } else {
    normal <- normal$name[1]
  }
  bold <- filter(data, style == "bold")
  if(NROW(bold) > 0){
    bold <- bold$name[1]
  } else {
    bold <- normal
  }
  italic <- dplyr::filter(data, style == "italic" | italic)
  if(NROW(italic) > 0){
    italic <- italic$name[1]
  } else {
    italic <- normal
  }
  bi <- dplyr::filter(data, style == "bold italic")
  if(NROW(bi) > 0){
    bi <- bi$name[1]
  } else {
    bi <- italic
  }
  return(c(normal = normal, bold = bold, italic = italic, bolditalic = bi))
}
