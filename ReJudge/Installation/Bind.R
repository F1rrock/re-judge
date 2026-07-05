source("ReJudge/Installation/Installation.R")
source("ReJudge/Installation/Lambda.R")

installation.bind <- function(l, r) {
  installation.lambda(
    function() {
      code(
        r(
          code(l)
        )
      )
    }
  )
}
