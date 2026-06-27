source("ReJudge/App/App.R")
source("ReJudge/Text/Text.R")
source("ReJudge/Text/Fstring.R")
source("ReJudge/Text/Palette.R")

app.console <- function(m) {
  structure(
    list(
      message = m
    ),
    class = "app_console"
  )
}

perform.app_console <- function(x) {
  tryCatch(
    cat(
      contents(
        text.fstring("\014%s", x$message)
      )
    ),
    error = function(e) {
      cat(
        contents(
          text.red(
            text.fstring(
              "Error: %s\n",
              conditionMessage(e)
            )
          )
        )
      )
    }
  )
}
