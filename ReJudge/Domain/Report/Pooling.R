source("ReJudge/Status/Status.R")
source("ReJudge/Text/Delegate.R")
source("ReJudge/Text/Delayed.R")

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
