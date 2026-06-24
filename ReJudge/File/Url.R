source("ReJudge/Text/Text.R")
source("ReJudge/File/File.R")

file.url <- function(p) {
  structure(
    list(
      path = p
    ),
    class = "file_url"
  )
}

path.file_url <- function(x) contents(x$path)

src.file_url  <- function(x) {
  paste(
    readLines(contents(x$path), warn = FALSE),
    collapse = "\n"
  )
}
