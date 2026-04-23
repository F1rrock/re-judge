source("ReJudge/Number/Number.R")
source("ReJudge/Text/Lambda.R")

text.scalar <- function(n){
  text.lambda(
    function() as.character(scalar(n))
  )
}
