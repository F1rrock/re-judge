source("Http/Connection/Connection.R")

connection.fake = function(r) {
  structure(
    list(
      response = r,
    ),
    class = "fake_connection"
  )
}

response.fake_connection  <- function(x) x$response
