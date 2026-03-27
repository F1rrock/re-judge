source("Text/Text.R")

text.fstring <- function(x, ...) {
  structure(
    list(
      form = x,
      args = list(...)
    ),
    class = "fstring_text"
  )
}

contents.fstring_text <- function(x) {
  do.call(
    sprintf,
    c(
      list(contents(x$form)), 
      lapply(x$args, contents)
    )
  )
}
