source("ReJudge/Text/Text.R")

text.nonempty <- function(x) {
  structure(
    list(
      origin  = x
    ),
    class = "text_nonempty"
  )
}

contents.text_nonempty <- function(x) {
  v <- contents(x$origin)
  if (identical(v, "")) return(NA_character_)
  v
}
