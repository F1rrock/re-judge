source("ReJudge/Http/Connection/Memo.R")
source("ReJudge/Http/Connection/Successful.R")
source("ReJudge/Http/Connection/Retried.R")
source("ReJudge/Http/Connection/Timed.R")
source("ReJudge/Http/Connection/Logged.R")

connection.ready <- function(x) {
  connection.memo(
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
  )
}
