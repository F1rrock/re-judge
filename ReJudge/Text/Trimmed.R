source("ReJudge/Text/Text.R")
source("ReJudge/Text/Lambda.R")

text.trimmed <- function(x) {
  text.lambda(
    function() {
      trimws(
        contents(x)
      )
    }
  )
}
