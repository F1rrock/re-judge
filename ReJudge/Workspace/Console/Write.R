source("ReJudge/Text/Text.R")
source("ReJudge/Effect/Lambda.R")

console.write <- function(msg) {
  effect.lambda(
    function() cat(contents(msg))
  )
}
