source("Src/Text/Text.R")
source("Src/Number/Lambda.R")

number.str <- function(s) {
  number.lambda(
    function() {
      as.numeric(
        contents(s)
      )
    }
  )
}
