perform <- function(x) UseMethod("perform")

perform.default <- function(x) {
  stop(
    sprintf(
      "perform() is not implemented for %s",
      paste(class(x), collapse = "/")
    )
  )
}
