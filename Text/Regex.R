source("Text/Text.R")

text.regex <- function(pattern, origin, default = NA_character_) {
  structure(
    list(
      pattern = pattern,
      origin = origin,
      default = default
    ),
    class = "regex_text"
  )
}

contents.regex_text <- function(x) {
  val <- contents(x$origin)
  first(
    contents(x$default),
    regmatches(
      val,
      regexec(contents(x$pattern), val)
    )[[1]][-1]
  )
}
