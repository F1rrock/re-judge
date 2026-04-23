source("ReJudge/Text/Lambda.R")
source("ReJudge/Script/Script.R")

text.result <- function(script) {
  text.lambda(function() result(script))
}
