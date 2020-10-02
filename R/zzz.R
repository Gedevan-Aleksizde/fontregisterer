.onLoad <- function(libname, pkgname){
  register_Fonts()

  if(Sys.info()["sysname"] == "Windows"){
    names(windowsFonts())
  }
  if(Sys.info()["sysname"] == "Darwin"){
    names(quartzFonts())
  }
}
