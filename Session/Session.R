html    <- function(x) UseMethod("html")
cookies <- function(x) UseMethod("cookies")

html.default <- function(x) {
  stop(
    sprintf(
      "html() is not implemented for %s",
      paste(class(x), collapse = "/")
    )
  )
}

cookies.default <- function(x) {
  stop(
    sprintf(
      "cookies() is not implemented for %s",
      paste(class(x), collapse = "/")
    )
  )
}
