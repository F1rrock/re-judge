source("ReJudge/File/File.R")

rstudio.current <- structure(
  list(),
  class = "rstudio_current"
)

path.rstudio_current <- function(x) {
  ctx  <- rstudioapi::getSourceEditorContext()
  path <- ctx$path
  if (identical(path, "")) return(NA_character_)
  path
}

src.rstudio_current <- function(x) {
  paste(
    readLines(path(x), warn = FALSE, encoding = "UTF-8"),
    collapse = "\n"
  )
}
