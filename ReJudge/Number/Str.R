source("ReJudge/Text/Text.R")
source("ReJudge/Number/Lambda.R")

number.str <- function(s) {
  number.lambda(
    function() {
      as.numeric(
        contents(s)
      )
    }
  )
}
