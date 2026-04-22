source("Src/Number/Number.R")
source("Src/Number/Lambda.R")

number.difference <- function(l, r) {
  number.lambda(
    function() {
      scalar(l) - scalar(r)
    }
  )
}
