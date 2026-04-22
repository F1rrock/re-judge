source("Src/Text/Text.R")

text.bind <- function(l, r) {
  structure(
    list(
      left = l,
      right = r
    ),
    class = "text_bind"
  )
}

contents.text_bind <- function(x) {
  left <- contents(x$left)
  contents(
    x$right(
      left
    )
  )
}
