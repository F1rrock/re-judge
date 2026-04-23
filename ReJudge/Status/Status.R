ok <- function(x) UseMethod("ok")

ok.default <- function(x) {
  stop(
    sprintf(
      "ok() is not implemented for %s",
      paste(class(x), collapse = "/")
    )
  )
}
