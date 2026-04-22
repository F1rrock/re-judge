source("Src/Session/Session.R")
source("Src/Text/Text.R")

session.fake = function(p, c) {
  structure(
    list(
      payload = p,
      cookies = c
    ),
    class = "fake_session"
  )
}

payload.fake_session   <- function(x) contents(x$payload)
cookies.fake_session   <- function(x) contents(x$cookies)
