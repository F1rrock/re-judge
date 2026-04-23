source("ReJudge/Text/Text.R")
source("ReJudge/Number/Number.R")

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
  Sys.sleep(scalar(x$seconds))
  contents(x$origin)
}
