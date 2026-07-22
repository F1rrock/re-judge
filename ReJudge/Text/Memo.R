source("ReJudge/Text/Text.R")
source("ReJudge/Text/Lambda.R")

text.memo <- function(origin) {
  cache <- new.env(parent = emptyenv())
  text.lambda(
    function() {
      if (!exists("val", envir = cache, inherits = FALSE)) {
        cache$val <- contents(origin)
      }
      cache$val
    }
  )
}
