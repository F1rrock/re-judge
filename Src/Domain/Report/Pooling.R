source("Src/Status/Status.R")
source("Src/Text/Delegate.R")
source("Src/Text/Delayed.R")

report.pooling <- function(status, downtime, origin) {
  self <- text.delegate(
    function() {
      if (ok(status)) return(origin)
      text.delayed(
        downtime,
        self
      )
    }
  )
  self
}
