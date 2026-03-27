headers <- function(x) UseMethod("headers")
body    <- function(x) UseMethod("body")

headers.default <- function(x) {
  stop(
    sprintf(
      "headers() is not implemented for %s",
      paste(class(x), collapse = "/")
    )
  )
}

body.default <- function(x) {
  stop(
    sprintf(
      "body() is not implemented for %s",
      paste(class(x), collapse = "/")
    )
  )
}
