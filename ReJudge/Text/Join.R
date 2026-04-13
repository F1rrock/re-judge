source("ReJudge/Text/Text.R")

text.join <- function(separator, xs) {
  structure(
    list(
      separator = separator,
      origin = xs
    ),
    class = "text_join"
  )
}

contents.text_join <- function(x) {
  paste(
    vapply(
      items(x$origin),
      contents,
      character(1)
    ),
    collapse = contents(x$separator)
  )
}
