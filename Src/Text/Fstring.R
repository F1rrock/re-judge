source("Src/Text/Text.R")

text.fstring <- function(x, ...) {
  structure(
    list(
      form = x,
      args = list(...)
    ),
    class = "text_fstring"
  )
}

contents.text_fstring <- function(x) {
  do.call(
    sprintf,
    c(
      list(contents(x$form)), 
      lapply(x$args, contents)
    )
  )
}
