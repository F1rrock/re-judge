source("Src/Text/Text.R")

text.required <- function(e = 'required value is not defined', x) {
  structure(
    list(
      onerror = e,
      origin  = x
    ),
    class = "text_required"
  )
}

contents.text_required <- function(x) {
  v <- contents(x$origin)
  if (is.na(v)) {
    stop(contents(x$onerror))
  }
  v
}
