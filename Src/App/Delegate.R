source("Src/App/App.R")

app.delegate <- function(f) {
  structure(
    list(
      callback = f
    ),
    class = "app_delegate"
  )
}

perform.app_delegate <- function(x) perform(x$callback())
