library(dotenv)
source("Text/Text.R")

text.env <- function(x) {
  structure(
    list(
      value = x
    ),
    class = "text_env"
  )
}

contents.text_env <- function(x) {
  load_dot_env()
  Sys.getenv(
    contents(x$value),
    unset = NA_character_
  )
}