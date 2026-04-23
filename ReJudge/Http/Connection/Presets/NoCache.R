source("ReJudge/Http/Connection/Successful.R")
source("ReJudge/Http/Connection/Retried.R")
source("ReJudge/Http/Connection/Timed.R")
source("ReJudge/Http/Connection/Logged.R")

connection.nocache <- function(x) {
  connection.successful(
    connection.retried(
      3,
      connection.timed(
        5,
        connection.logged(
          "fetching connection...",
          x
        )
      )
    )
  )
}
