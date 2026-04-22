source("Src/Text/Text.R")
source("Src/File/File.R")

file.required <- function(e = "required file path is not defined", x) {
  structure(
    list(
      onerror = e,
      origin  = x
    ),
    class = "file_required"
  )
}

path.file_required <- function(x) {
  p <- path(x$origin)
  if (is.na(p)) {
    stop(contents(x$onerror))
  }
  p
}

src.file_required <- function(x) {
  s <- src(x$origin)
  if (is.na(s)) {
    stop(contents(x$onerror))
  }
  s
}
