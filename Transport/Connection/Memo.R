source("Transport/Connection/Connection.R")

connection.memo = function(x) {
  structure(
    list(
      origin = x,
      cache  = new.env(
        parent = emptyenv()
      )
    ),
    class = "connection_memo"
  )
}

response.connection_memo  <- function(x) {
  if (!exists("val", envir = x$cache, inherits = FALSE)) {
    x$cache$val <- response(x$origin)
  }
  x$cache$val
}
