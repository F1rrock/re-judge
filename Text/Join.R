source("Text/Text.R")

text.join <- function(separator, xs) {
  structure(
    list(
      separator = separator,
      origin = xs
    ),
    class = "join_text"
  )
}

contents.join_text <- function(x) {
  paste(
    vapply(
      items(x$origin),
      contents,
      character(1)
    ),
    collapse = contents(x$separator)
  )
}
