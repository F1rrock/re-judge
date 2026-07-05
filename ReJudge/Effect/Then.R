source("ReJudge/Effect/Effect.R")
source("ReJudge/Effect/Lambda.R")

effect.then <- function(l, r) {
  effect.lambda(
    function() {
      realize(l)
      realize(r)
    }
  )
}
