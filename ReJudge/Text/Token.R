source("ReJudge/Text/Text.R")
source("ReJudge/Token/Token.R")

text.token <- function(t) {
  structure(
    list(
      token = t
    ),
    class = "text_token"
  )
}

contents.text_token <- function(x) value(x$token)
