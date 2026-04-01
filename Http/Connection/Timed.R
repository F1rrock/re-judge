source("Http/Connection/Connection.R")

connection.timed <- function(s, x) {
  structure(
    list(
      seconds = s,
      origin  = x
    ),
    class = "connection_timed"
  )
}

response.connection_timed <- function(x) {
  setTimeLimit(
    elapsed = x$seconds, 
    transient = TRUE
  )
  on.exit(
    setTimeLimit(
      cpu = Inf, 
      elapsed = Inf, 
      transient = FALSE
    )
  )
  response(x$origin)
}
