source("ReJudge/Status/Status.R")

status.always <- function(state) {
  structure(
    list(
      state = state
    ),
    class = "status_always"
  )
}

ok.status_always <- function(x) x$state
