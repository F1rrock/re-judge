val <- function(x) UseMethod("val")
name <- function(x) UseMethod("name")
ref <- function(x) UseMethod("ref")

val.default <- function(x) {
  stop(
    sprintf(
      "val() is not implemented for %s",
      paste(class(x), collapse = "/")
    )
  )
}

name.default <- function(x) {
  stop(
    sprintf(
      "name() is not implemented for %s",
      paste(class(x), collapse = "/")
    )
  )
}

ref.default <- function(x) {
  stop(
    sprintf(
      "ref() is not implemented for %s",
      paste(class(x), collapse = "/")
    )
  )
}
