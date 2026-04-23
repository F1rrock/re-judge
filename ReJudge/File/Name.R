source("ReJudge/Text/Text.R")
source("ReJudge/File/File.R")

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
