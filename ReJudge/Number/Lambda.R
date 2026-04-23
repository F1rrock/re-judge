source("ReJudge/Number/Number.R")

number.lambda <- function(f) {
  structure(
    list(
      callback = f
    ),
    class = "number_lambda"
  )
}

scalar.number_lambda <- function(x) x$callback()
