source("ReJudge/Number/Number.R")
source("ReJudge/Number/Lambda.R")

number.difference <- function(l, r) {
  number.lambda(
    function() {
      scalar(l) - scalar(r)
    }
  )
}
