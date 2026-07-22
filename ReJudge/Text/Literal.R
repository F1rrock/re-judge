source("ReJudge/Text/Text.R")
source("ReJudge/Text/Lambda.R")

text.literal <- function(origin) {
  text.lambda(
    function() {
      deparse(
        contents(
          origin
        )
      )
    }
  )
}
