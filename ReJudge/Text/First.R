source("ReJudge/Text/Delegate.R")

text.first <- function(default, xs) {
  text.delegate(
    function() {
      xs <- items(xs)
      if (length(xs) <= 0) return(default)
      xs[[1]]
    }
  )
}
