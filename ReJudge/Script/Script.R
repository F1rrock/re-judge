result <- function(x) UseMethod("result")

result.default <- function(x) {
  stop(
    sprintf(
      "result() is not implemented for %s",
      paste(class(x), collapse = "/")
    )
  )
}
