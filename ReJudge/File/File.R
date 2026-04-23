path <- function(x) UseMethod("path")
ReJudge  <- function(x) UseMethod("ReJudge")

path.default <- function(x) {
  stop(
    sprintf(
      "path() is not implemented for %s",
      paste(class(x), collapse = "/")
    )
  )
}

ReJudge.default <- function(x) {
  stop(
    sprintf(
      "ReJudge() is not implemented for %s",
      paste(class(x), collapse = "/")
    )
  )
}
