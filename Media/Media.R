src <- function(x) UseMethod("src")

src.default <- function(x) {
  stop(
    sprintf(
      "src() is not implemented for %s",
      paste(class(x), collapse = "/")
    )
  )
}
