entry <- function(x) UseMethod("entry")

entry.default <- function(x) {
  stop(
    sprintf(
      "entry() is not implemented for %s",
      paste(class(x), collapse = "/")
    )
  )
}
