source("ReJudge/Session/Session.R")

session.logged <- function(x) {
  structure(
    list(
      origin = x
    ),
    class = "session_logged"
  )
}

payload.session_logged <- function(x) {
  cat("fetching payload...\n")
  payload(x$origin)
}

cookies.session_logged <- function(x) {
  cat("fetching cookies...\n")
  cookies(x$origin)
}
