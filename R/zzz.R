
.onLoad <- function(libname, pkgname){
}

.onAttach <- function(libname, pkgname){
  register_all_fonts()
  if(Sys.info()["sysname"] == "Windows"){
    packageStartupMessage("You can see available font families by `names(windowsFonts())`")
  } else if(Sys.info()["sysname"] == "Darwin"){
    packageStartupMessage("You can see available font families by `names(quartzFonts())`")
  } else {
    packageStartupMessage("This package does nothing if your operating system is neither Mac nor Windows.")
    packageStartupMessage("You can see available font families by `systemfonts::system_fonts()$family`.")
  }
}
