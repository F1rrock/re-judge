source("ReJudge/Text/Lambda.R")
source("ReJudge/Installation/Installation.R")

text.code <- function(x) {
  text.lambda(
    function() {
      code(x)
    }
  )
}
