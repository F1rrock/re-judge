source("Src/Text/Text.R")
source("Src/Session/Session.R")

text.payload <- function(s) {
  structure(
    list(
      session = s
    ),
    class = "text_payload"
  )
}

contents.text_payload <- function(x) {
  payload(x$session)
}
