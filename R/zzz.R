.onLoad <- function(libname, pkgname){
  register_all_fonts()

  if(Sys.info()["sysname"] == "Windows"){
    message("You can see available font families by `names(windowsFonts())` ")
  } else if(Sys.info()["sysname"] == "Darwin"){
    message("You can see available font families by `names(quartzFonts())` ")
  } else {
    message("This package does nothing if your operating system is neither Mac nor Windows.")
    message("You can see available font families by `systemfonts::system_fonts()$family`.")
  }
}
