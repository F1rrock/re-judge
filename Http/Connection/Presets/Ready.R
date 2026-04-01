source("Http/Connection/Memo.R")
source("Http/Connection/Successful.R")
source("Http/Connection/Retried.R")
source("Http/Connection/Timed.R")
source("Http/Connection/Logged.R")

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
