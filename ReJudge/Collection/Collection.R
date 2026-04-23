items <- function(x) UseMethod("items")

items.default <- function(x) {
  stop(
    sprintf(
      "items() is not implemented for %s",
      paste(class(x), collapse = "/")
    )
  )
}

items.list <- function(x) x
