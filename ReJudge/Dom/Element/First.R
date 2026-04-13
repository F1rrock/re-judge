source("ReJudge/Dom/Element/Delegate.R")

element.first <- function(default, xs) {
  element.delegate(
    function() {
      xs <- items(xs)
      if (length(xs) <= 0) return(default)
      xs[[1]]
    }
  )
}
