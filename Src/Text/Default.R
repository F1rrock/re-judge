source("Src/Text/Text.R")

text.default <- function(fallback, origin) {
  structure(
    list(
      fallback = fallback,
      origin = origin
    ),
    class = "text_default"
  )
}

contents.text_default <- function(x) {
  v <- contents(x$origin)
  if (is.na(v)) {
    return(
      contents(
        x$fallback
      )
    )
  }
  v
}
