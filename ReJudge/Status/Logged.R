source("ReJudge/Text/Text.R")
source("ReJudge/Status/Status.R")

status.logged <- function(m, v) {
  structure(
    list(
      message = m,
      value = v
    ),
    class = "text_logged"
  )
}

ok.text_logged <- function(x) {
  cat(contents(x$message), "\n")
  ok(x$value)
}
