source("ReJudge/Script/Context/Context.R")

context.lambda <- function(f) {
  structure(
    list(
      callback = f
    ),
    class = "context_lambda"
  )
}

core.context_lambda <- function(x) x$callback()
