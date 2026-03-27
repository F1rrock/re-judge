source("Session/Session.R")

text.html <- function(s) {
  structure(
    list(
      session = s
    ),
    class = "html_text"
  )
}

contents.html_text <- function(x) {
  html(x$session)
}