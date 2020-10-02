.onLoad <- function(libname, pkgname){
  register_all_fonts()

  if(Sys.info()["sysname"] == "Windows"){
    print(names(windowsFonts()))
  } else if(Sys.info()["sysname"] == "Darwin"){
    print(names(quartzFonts()))
  } else {
    print("This package does nothing if your operating system is not Mac or Windows.")
  }
}
