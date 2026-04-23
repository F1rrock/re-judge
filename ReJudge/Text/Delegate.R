source("ReJudge/Text/Text.R")

text.delegate <- function(f) {
  structure(
    list(
      callback = f
    ),
    class = "text_delegate"
  )
}

contents.text_delegate <- function(x) contents(x$callback())
