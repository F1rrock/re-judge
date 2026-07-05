realize <- function(x) UseMethod("realize")

realize.default <- function(x) {
  stop(
    sprintf(
      "realize() is not implemented for %s",
      paste(class(x), collapse = "/")
    )
  )
}

