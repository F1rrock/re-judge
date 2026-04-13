source("ReJudge/Text/Text.R")

text.plain <- function(x) {
  structure(
    list(
      origin = x
    ),
    class = "text_plain"
  )
}

contents.text_plain   <- function(x) contents(x$origin)
