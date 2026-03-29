dom <- function(x) UseMethod("dom")

dom.default <- function(x) {
  stop(
    sprintf(
      "dom() is not implemented for %s",
      paste(class(x), collapse = "/")
    )
  )
}
