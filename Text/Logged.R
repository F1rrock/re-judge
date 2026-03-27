source("Text/Text.R")

text.logged <- function(m, v) {
  structure(
    list(
      message = m,
      value = v
    ),
    class = "text_logged"
  )
}

contents.text_logged <- function(x) {
  cat(contents(x$message), "\n")
  contents(x$value)
}