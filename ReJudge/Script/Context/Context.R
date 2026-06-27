core <- function(x) UseMethod("core")

core.default <- function(x) {
  stop(
    sprintf(
      "core() is not implemented for %s",
      paste(class(x), collapse = "/")
    )
  )
}
