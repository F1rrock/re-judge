source("Transport/Connection/Memo.R")
source("Transport/Connection/Successful.R")
source("Transport/Connection/Retried.R")
source("Transport/Connection/Timed.R")
source("Transport/Connection/Logged.R")

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
