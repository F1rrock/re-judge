source("Transport/Connection/Connection.R")

connection.retried <- function(t, x) {
  structure(
    list(
      times = t,
      origin = x
    ),
    class = "connection_retried"
  )
}

response.connection_retried <- function(x) {
  attempt <- function(remaining) {
    tryCatch(
      response(x$origin),
      error = function(e) {
        if (remaining <= 1) stop(e)
        attempt(remaining - 1)
      }
    )
  }
  attempt(x$times)
}
