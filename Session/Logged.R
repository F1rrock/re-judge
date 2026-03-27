source("Session/Session.R")

session.logged <- function(x) {
  structure(
    list(
      origin = x
    ),
    class = "session_logged"
  )
}

html.session_logged <- function(x) {
  cat("fetching html...\n")
  html(x$origin)
}

cookies.session_logged <- function(x) {
  cat("fetching cookies...\n")
  cookies(x$origin)
}
