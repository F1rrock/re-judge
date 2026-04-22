path <- function(x) UseMethod("path")
src  <- function(x) UseMethod("src")

path.default <- function(x) {
  stop(
    sprintf(
      "path() is not implemented for %s",
      paste(class(x), collapse = "/")
    )
  )
}

src.default <- function(x) {
  stop(
    sprintf(
      "src() is not implemented for %s",
      paste(class(x), collapse = "/")
    )
  )
}
