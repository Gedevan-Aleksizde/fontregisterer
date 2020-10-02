#' get OS standard font
#' @export
get_standard_font <- function(){
  if(Sys.info()["sysname"] == "Windows"){
    if(as.integer(str_extract(Sys.info()["release"], "^[0-9]+")) >=8){
      # 游書体はWindows 8 以降は入っているはず
      family_sans <- "Yu Gothic"
      family_serif <- "Yu Mincho"
    } else {
      family_sans <- "MS Gothic"
      family_serif <- "MS Mincho"
    }
    # その他有効な名称
    # family_sans <- "MS PGothic"
    # family_serif <- "MS PMincho"
    # 最近のWin10には入っているが, なんか認識しない
    # family_sans <- "BIZ UDMincho"
    # family_serif <- "BIZ UDGothic"
  } else if(Sys.info()["sysname"] == "Linux") {
    family_sans <- "Noto Sans CJK JP"
    family_serif <- "Noto Serif CJK JP"
  } else if(Sys.info()["sysname"] == "Darwin"){
    # quartzFonts に登録すると動く
    family_serif <- "Hiragino Mincho ProN"
    family_sans <- "Hiragino Sans"
  } else {
    # インストールすればとりあえず動く
    family_sans <- "IPAexゴシック"
    family_serif <- "IPAex明朝"
  }
  return(c(sans = family_sans, serif = family_serif))
}
