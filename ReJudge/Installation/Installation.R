code <- function(x) UseMethod("code")

code.default <- function(x) {
  stop(
    sprintf(
      "code() is not implemented for %s",
      paste(class(x), collapse = "/")
    )
  )
}
