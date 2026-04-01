source("Http/Connection/Connection.R")
source("Text/Text.R")

connection.logged <- function(m, v) {
  structure(
    list(
      message = m,
      value = v
    ),
    class = "connection_logged"
  )
}

response.connection_logged <- function(x) {
  cat(contents(x$message), "\n")
  response(x$value)
}
