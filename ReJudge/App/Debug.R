source("ReJudge/App/App.R")
source("ReJudge/Text/Text.R")
source("ReJudge/Text/Fstring.R")
source("ReJudge/Text/Palette.R")

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
