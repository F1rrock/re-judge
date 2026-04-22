source("Src/Number/Number.R")
source("Src/Text/Lambda.R")

text.scalar <- function(n){
  text.lambda(
    function() as.character(scalar(n))
  )
}
