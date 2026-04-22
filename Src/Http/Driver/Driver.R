request    <- function(x) UseMethod("request")
attachment <- function(x) UseMethod("attachment")

request.default <- function(x) {
  stop(
    sprintf(
      "request() is not implemented for %s",
      paste(class(x), collapse = "/")
    )
  )
}

attachment.default <- function(x) {
  stop(
    sprintf(
      "attachment() is not implemented for %s",
      paste(class(x), collapse = "/")
    )
  )
}
