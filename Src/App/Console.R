source("Src/App/App.R")
source("Src/Text/Text.R")
source("Src/Text/Fstring.R")
source("Src/Text/Palette.R")

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
              "Error: %s",
              conditionMessage(e)
            )
          )
        )
      )
    }
  )
}
