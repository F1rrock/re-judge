source("Src/Text/Lambda.R")
source("Src/Script/Script.R")

text.result <- function(script) {
  text.lambda(function() result(script))
}
