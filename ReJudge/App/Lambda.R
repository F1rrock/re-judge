source("ReJudge/App/App.R")

app.lambda <- function(f) {
  structure(
    list(
      callback = f
    ),
    class = "app_lambda"
  )
}

perform.app_lambda <- function(x) x$callback()
