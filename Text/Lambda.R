source("Text/Text.R")

text.lambda <- function(f) {
  structure(
    list(
      callback = f
    ),
    class = "text_lambda"
  )
}

contents.text_lambda <- function(x) x$callback()
