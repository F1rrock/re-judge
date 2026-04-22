doc <- function(x) UseMethod("doc")

doc.default <- function(x) {
  stop(
    sprintf(
      "doc() is not implemented for %s",
      paste(class(x), collapse = "/")
    )
  )
}
