download <- function(x) UseMethod("download")

download.default <- function(x) {
  stop(
    sprintf(
      "download() is not implemented for %s",
      paste(class(x), collapse = "/")
    )
  )
}
