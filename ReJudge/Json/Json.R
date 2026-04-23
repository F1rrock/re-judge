fields <- function(x) UseMethod("fields")

fields.default <- function(x) {
  stop(
    sprintf(
      "fields() is not implemented for %s",
      paste(class(x), collapse = "/")
    )
  )
}
