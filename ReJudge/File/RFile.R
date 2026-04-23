source("ReJudge/Text/Text.R")
source("ReJudge/File/File.R")
source("ReJudge/File/Extension.R")

file.r <- function(f) {
  structure(
    list(
      origin = f
    ),
    class = "file_r"
  )
}

path.file_r <- function(x) {
  extension <- contents(
    file.extension(
      x$origin
    )
  )
  if (identical(extension, "R")) {
    return(path(x$origin))
  }
  NA_character_
}

ReJudge.file_r  <- function(x) {
  ReJudge(x$origin)
}
