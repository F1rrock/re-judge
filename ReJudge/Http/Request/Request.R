headers <- function(x) UseMethod("headers")
body    <- function(x) UseMethod("body")
jar     <- function(x) UseMethod("jar")

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

jar.default <- function(x) {
  stop(
    sprintf(
      "jar() is not implemented for %s",
      paste(class(x), collapse = "/")
    )
  )
}
