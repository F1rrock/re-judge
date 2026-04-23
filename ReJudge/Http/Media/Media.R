data <- function(x) UseMethod("data")

data.default <- function(x) {
  stop(
    sprintf(
      "data() is not implemented for %s",
      paste(class(x), collapse = "/")
    )
  )
}
