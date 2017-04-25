.onAttach <- function(libname, pkgname) {
  packageStartupMessage("Welcome to getmstatistic \n see https://magosil86.github.io/getmstatistic/ for examples and documentation")
}


.onLoad <- function(libname, pkgname) {
  op <- options()
  op.getmstatistic <- list(
    getmstatistic.path = "",
    getmstatistic.install.args = "",
    getmstatistic.name = "Lerato E. Magosi",
    getmstatistic.desc.author = '"Lerato E. Magosi <magosil86@gmail.com> [aut, cre]"',
    getmstatistic.desc.license = "MIT",
    getmstatistic.desc.suggests = NULL,
    getmstatistic.desc = list()
  )
  toset <- !(names(op.getmstatistic) %in% names(op))
  if(any(toset)) options(op.getmstatistic[toset])

  invisible()
}