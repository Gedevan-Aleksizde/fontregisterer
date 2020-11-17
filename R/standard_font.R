#' @title get OS standard font families
#' @export
#' @description get OS-tandard Japanese font family names
#' @return character vector of length 2. These elements are names of (1) Sans (Gothic) and (2) Serif (Mincho), Japanese font families which are installed standardly in your operating system.
#' @details This function returns character vector of length 2 which are standard Japanese font families for each operating system. Thus these families are OS-specified:
#'
#' | OS            | Sans                 | Serif                    |
#' | ------------- |:--------------------:|:------------------------:|
#' | Linux         | `"Noto Sans CJK JP"` | `"Noto Serif CJK JP"`    |
#' | Mac           | `"Hiragino Sans"`    | `"Hiragino Mincho ProN"` |
#' | Windows (>=8) | `"Yu Gothic"`        | `"Yu Gothic"`            |
#' | Windows (<8)  | `"MS Gothic"`        | `"MS Mincho"`            |
#'
#' @md
#'
get_standard_ja_fonts <- function(){
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
#' @importFrom systemfonts system_fonts
#' @title set standard \code{sans}/\code{serif} family so that to refer the OS standard font
#' @description change default Serif/Sans Serif fonts for Windows & Mac OS / Windows および Mac で \code{sans}/\code{serif} の参照するフォントを変更する. デフォルトはOSごとの標準日本語フォント
set_ja_font_standard <- function(sans = NULL, serif = NULL){
  is_linux <- Sys.info()["sysname"] == "Linux"
  if(is_linux) message("This function doesn't change font reference names if your operating system is Linux. If you want to change default font, please check out your system fontconfig")
  families <- get_standard_ja_fonts()
  if(!is.null(sans) && is.character(sans)) families["sans"] <- sans
  if(!is.null(serif) && is.character(serif)) families["serif"] <- serif
  if(Sys.info()["sysname"] == "Windows"){
    do.call(windowsFonts(setnames(list(windowsFont(families["sans"]), windowsFont(families["serif"])), c(families))))
    default_families <- families
  } else if(Sys.info()["sysname"] == "Darwin"){
    quartzFonts(
      sans = quartzFont(get_styles(subset(system_fonts(), family == families["sans"]))),
      serif = quartzFont(get_styles(subset(system_fonts(), family == families["serif"])))
    )
    default_families <- c("sans", "serif")
  }
  if(!is_linux){
    message(gettextf("`%s` will refer to %s family", sans = default_families[1], families["sans"]))
    message(gettextf("`%s` will refer to %s family", serif = default_families[2], families["serif"]))
  }
  if("ggplot2" %in% .packages()){
    getFromNamespace("theme_set", "ggplot2")(getFromNamespace("theme", "ggplot2")(
      text = getFromNamespace("element_text", "ggplot2")(family = default_families[1])
    ))
    getFromNamespace("update_geom_defaults", "ggplot2")("text", list(family = default_families[1]))
    getFromNamespace("update_geom_defaults", "ggplot2")("label", list(family = default_families[1]))
    message(gettextf("`%s` package will use %s as the default font family", pkg = "ggplot2", sans = default_families[1]))
  }
  if("ggrepel" %in% .packages()){
    getFromNamespace("update_geom_defaults", "ggplot2")("text_repel", list(family = default_families[1]))
    getFromNamespace("update_geom_defaults", "ggplot2")("label_repel", list(family = default_families[1]))
    message(gettextf("`%s` package will use %s as the default font family", pkg = "ggrepel", sans = default_families[1]))
  }
}
