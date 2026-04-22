scalar <- function(x) UseMethod("scalar")

scalar.default <- function(x) {
  stop(
    sprintf(
      "scalar() is not implemented for %s",
      paste(class(x), collapse = "/")
    )
  )
}

scalar.numeric <- function(x) x
scalar.integer <- function(x) as.numeric(x)
