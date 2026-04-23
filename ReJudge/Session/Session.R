payload <- function(x) UseMethod("payload")
cookies <- function(x) UseMethod("cookies")

payload.default <- function(x) {
  stop(
    sprintf(
      "payload() is not implemented for %s",
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
