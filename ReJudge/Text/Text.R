contents <- function(x) UseMethod("contents")

contents.default <- function(x) {
  stop(
    sprintf(
      "contents() is not implemented for %s",
      paste(class(x), collapse = "/")
    )
  )
}

contents.character <- function(x) x
