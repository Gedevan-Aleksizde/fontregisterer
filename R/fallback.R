#'
#' @title Convert a image file with font-fallbacking settings
#' @description Convert a svg file to other format like png, pdf, etc. by librsvg2 with font-fallbacking settings.
#' @inheritParams rsvg::rsvg
#' @param filename character. output file path
#' @param type character. One of `pdf`, `png`, `ps`, `svg`, `webp` is available and the default is `png`. The webp package is required if you choose `webp`
#' @param family character. The fallbacking font family name. if you specify `NULL`, fontregisterer's default Japanese font family (see \code{\link{get_standard_ja_fonts}}) is specified is applied. If `css` is specified, `css` override this parameter.
#' @export
#'
rsvg_fallback <- function(svg, filename, type = "png", family = NULL, css = NULL, width = NULL, height = NULL){
  if(!type %in% c("pdf", "png", "ps", "svg", "raw", "webp")){
    stop(sprintf("type `%s` is not available."))
  }
  if(is.null(css)){
    css <- tempfile()
    if(is.null(family)){
      family <- get_standard_ja_fonts()[1]
    }
    writeLines(text = sprintf('text {font-family: "%s";}', family), css)
  }
  eval(parse(text = paste0("rsvg::rsvg_", type)[1]))(svg, filename, css = css, width = width, height = height)
  file.remove(css)
  return(NULL)
}
