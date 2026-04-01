node <- function(x) UseMethod("node")

node.default <- function(x) {
  stop(
    sprintf(
      "node() is not implemented for %s",
      paste(class(x), collapse = "/")
    )
  )
}
