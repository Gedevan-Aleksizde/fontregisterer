#' Register Fonts / フォントを登録する
#' @importFrom systemfonts system_fonts
#' @description register all system fonts obtained from `systemfonts` package by `windowsFonts` or `quartzFonts`/ `systemfonts` で取得したフォント名を全てOS固有のデバイス (`windowsFonts`, `quartzFonts`) に登録する.
#' @export
register_all_fonts <- function(){
  if(Sys.info()["sysname"] %in% c("Darwin", "Windows")){
    f <- aggregate(. ~ family + name, data = system_fonts(), FUN = function(x) unique(x)[1])
    # TODO: why???
    f$path <- as.character(f$path)
    f$index <- as.integer(f$index)
    f$style <- as.character(f$style)
    f$width <- as.integer(f$width)
    f$weight <- as.integer(f$weight)
    f$italic <- as.logical(f$italic)
    f$monospace <- as.logical(f$monospace)
    f <- lapply(setNames(as.list(unique(f$family)), unique(f$family)), function(x) get_styles(subset(f, family == x)))

  }
  if(Sys.info()["sysname"] == "Windows"){
    do.call(windowsFonts, setNames(lapply(names(f), windowsFont), names(f)))
  } else if(Sys.info()["sysname"] == "Darwin"){
    do.call(quartzFonts, setNames(lapply(f, quartzFont), names(f)))
  } else {
    warning("This function does not register any font because your operating system is neither Mac nor Windows")
  }
}
