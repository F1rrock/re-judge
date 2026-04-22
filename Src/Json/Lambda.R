source("Src/Json/Json.R")

json.lambda <- function(f) {
  structure(
    list(
      callback = f
    ),
    class = "json_lambda"
  )
}

fields.json_lambda <- function(x) x$callback()
