source("Session/Session.R")
source("Text/Text.R")

session.fake = function(h, c, j) {
  structure(
    list(
      html = h,
      cookies = c
    ),
    class = "fake_session"
  )
}

html.fake_session      <- function(x) contents(x$html)
cookies.fake_session   <- function(x) contents(x$cookies)
