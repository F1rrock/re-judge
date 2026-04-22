source("Src/Text/Text.R")

status.delegate <- function(f) {
  structure(
    list(
      callback = f
    ),
    class = "status_delegate"
  )
}

ok.status_delegate <- function(x) ok(x$callback())
