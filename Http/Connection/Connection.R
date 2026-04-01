response <- function(x) UseMethod("response")

response.default <- function(x) {
  stop(
    sprintf(
      "response() is not implemented for %s",
      paste(class(x), collapse = "/")
    )
  )
}
