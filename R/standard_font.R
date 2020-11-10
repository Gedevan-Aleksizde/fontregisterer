#' @title get OS standard font
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

#' @export
#' @title set standard \code{sans}/\code{serif} family so that to refer the OS standard font
#' @description change default Serif/Sans Serif fonts for Windows & Mac OS / Windows および Mac で \code{sans}/\code{serif} の参照するフォントを変更する. デフォルトはOSごとの標準日本語フォント
set_standard_font <- function(sans = NULL, serif = NULL){
  if(Sys.info()["sysname"] == "Linux") stop("This function is invalid for Linux OS. If you want to change default font, please check out your system fontconfig or insteadly using quartz device.")
  familes <- get_standard_font()
  if(!is.null(sans) && is.character(sans)) families["sans"] <- sans
  if(!is.null(serif) && is.character(serif)) families["serif"] <- serif
  if(Sys.info()["sysname"] == "Windows"){
    windowsFonts(sans = windowsFont(families["sans"]),
                 serif = windowsFont(families["serif"])
                 )
  } else if(Sys.info()["sysname"] == "Darwin"){
    quartzFonts(
      sans = quartzFont(rep(families["sans"], 4)),
      serif = quartzFont(rep(families["serif"], 4))
    )
  }
  cat("font family `sans` will refer to", families["sans"])
  cat("font family `serif` will refer to", families["serif"])
}
