connection.successful <- function(x) {
  structure(
    list(
      origin = x
    ),
    class = "connection_successful"
  )
}

response.connection_successful <- function(x) {
  r <- response(x$origin)
  s <- r$status()
  if (s < 200 || s >= 300) {
    stop(
      sprintf("unexpected status: %s", s)
    )
  }
  r
}
