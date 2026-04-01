value <- function(x) UseMethod("value")
expiration <- function(x) UseMethod("expiration")

value.default <- function(x) {
  stop(
    sprintf(
      "value() is not implemented for %s",
      paste(class(x), collapse = "/")
    )
  )
}

expiration.default <- function(x) NA
