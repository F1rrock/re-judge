source("ReJudge/Text/Text.R")

text.delayed <- function(sec, x) {
  structure(
    list(
      seconds = sec,
      origin  = x
    ),
    class = "text_delayed"
  )
}

contents.text_delayed <- function(x) {
  Sys.sleep(x$seconds)
  contents(x$origin)
}
