value <- function(x) UseMethod("value")

value.default <- function(x) {
  stop(
    sprintf(
      "value() is not implemented for %s",
      paste(class(x), collapse = "/")
    )
  )
}
