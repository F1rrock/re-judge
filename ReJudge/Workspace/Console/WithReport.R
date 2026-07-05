source("ReJudge/Text/Palette.R")
source("ReJudge/Text/Fstring.R")
source("ReJudge/Effect/Effect.R")
source("ReJudge/Effect/Lambda.R")
source("ReJudge/Workspace/Console/Write.R")

console.withreport <- function(origin) {
  effect.lambda(
    function() {
      tryCatch(
        realize(origin),
        error = function(e) {
          realize(
            console.write(
              text.red(
                text.fstring(
                  "Error: %s\n",
                  conditionMessage(e)
                )
              )
            )
          )
        }
      )
    }
  )
}
