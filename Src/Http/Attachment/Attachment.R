multipart <- function(x) UseMethod("multipart")

multipart.default <- function(x) {
  stop(
    sprintf(
      "multipart() is not implemented for %s",
      paste(class(x), collapse = "/")
    )
  )
}
