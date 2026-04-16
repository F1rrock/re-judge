source("ReJudge/Status/Delegate.R")

status.first <- function(default, xs) {
  status.delegate(
    function() {
      xs <- items(xs)
      if (length(xs) <= 0) return(default)
      xs[[1]]
    }
  )
}
