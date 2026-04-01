source("Text/Text.R")
source("Session/Session.R")

text.html <- function(s) {
  structure(
    list(
      session = s
    ),
    class = "text_html"
  )
}

contents.text_html <- function(x) {
  html(x$session)
}
