SAMPLETEXT <- "
123abcABCoO0lL1 日本語 简化字 正體字 Русский Українська हिंदी বাংল اللغة العربية 𒀝𒅗𒁺𒌑
"

#' load-time processing
.onAttach <- function(libname, pkgname){
  register_all_fonts()
  if(Sys.info()["sysname"] == "Windows"){
    funcname_fflist <- "names(windowsFonts())"
    packageStartupMessage(gettextf("You can see available font families by `%s`", funcname_fflist, domain = "R-fontregisterer"))
  } else if(Sys.info()["sysname"] == "Darwin"){
    funcname_fflist <- "names(quartzFonts())"
    packageStartupMessage(gettextf("You can see available font families by `%s`", funcname_fflist, domain = "R-fontregisterer"))
  } else {
    funcname_fflist <- "systemfonts::system_fonts()$family"
    packageStartupMessage("This package does not register any font when importing if your operating system is neither Mac nor Windows", domain = "R-fontregisterer")
    packageStartupMessage(gettextf("You can see available font families by `%s`", funcname_fflist, domain = "R-fontregisterer"))
  }
}
