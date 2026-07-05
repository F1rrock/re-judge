source("ReJudge/Effect/Effect.R")
source("ReJudge/App/Lambda.R")

app.effect <- function(effect) {
  app.lambda(
    function() realize(effect)
  )
}
