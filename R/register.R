#' Register Fonts / フォントを登録する
#' @description register all system fonts obtained from `systemfonts` package by `windowsFonts` or `quartzFonts`/ `systemfonts` で取得したフォント名を全てOS固有のデバイス (`windowsFonts`, `quartzFonts`) に登録する.
#' @export
register_all_fonts <- function(){
  if(Sys.info()["sysname"] %in% c("Darwin", "Windows")){
    f <- dplyr::mutate(
      tidyr::nest(
        dplyr::group_by(
          dplyr::ungroup(
            dplyr::summarise_all(
              dplyr::group_by(systemfonts::system_fonts(), family, name), ~.x[1]
            )
          ),
          family
        )
      ),
      style = purrr::map(data, get_styles)
    )
  }
  if(Sys.info()["sysname"] == "Windows"){
    do.call(windowsFonts, setNames(lapply(f$family, windowsFont), f$family))
  } else if(Sys.info()["sysname"] == "Darwin"){
    do.call(quartzFonts, setNames(lapply(f$style, quartzFont), f$family))
  }
}
