source("ReJudge/Installation/Installation.R")

installation.lambda <- function(f) {
  structure(
    list(
      callback = f
    ),
    class = "installation_lambda"
  )
}

code.installation_lambda <- function(x) x$callback()
