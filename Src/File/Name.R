source("Src/Text/Text.R")
source("Src/File/File.R")

file.name <- function(f) {
  structure(
    list(
      origin = f
    ),
    class = "file_name"
  )
}

contents.file_name <- function(x) {
  basename(path(x$origin))
}
