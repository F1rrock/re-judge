input  <- function(x) UseMethod("input")
output <- function(x) UseMethod("output")

input.default <- function(x) {
  stop(
    sprintf(
      "input() is not implemented for %s",
      paste(class(x), collapse = "/")
    )
  )
}

output.default <- function(x) {
  stop(
    sprintf(
      "output() is not implemented for %s",
      paste(class(x), collapse = "/")
    )
  )
}
