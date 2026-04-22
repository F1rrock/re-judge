source("Src/App/App.R")
source("Src/Text/Text.R")
source("Src/Text/Fstring.R")
source("Src/Text/Palette.R")

app.debug <- function(m) {
  structure(
    list(
      message = m
    ),
    class = "app_debug"
  )
}

perform.app_debug <- function(x) {
  cat(
    contents(x$message)
  )
}
