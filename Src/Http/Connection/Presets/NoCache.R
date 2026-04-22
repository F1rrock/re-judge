source("Src/Http/Connection/Successful.R")
source("Src/Http/Connection/Retried.R")
source("Src/Http/Connection/Timed.R")
source("Src/Http/Connection/Logged.R")

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
