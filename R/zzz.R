.onLoad <- function(libname, pkgname){
  register_Fonts()

  if(Sys.info()["sysname"] == "Windows"){
    names(windowsFonts())
  }
  if(Sys.info()["sysname"] == "Darwin"){
    names(quartzFonts())
  } else {
    print("This package does nothing if your operating system is not Mac or Windows.")
  }
}
