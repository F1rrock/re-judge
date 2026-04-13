source("ReJudge/Collection/Lambda.R")
source("ReJudge/Text/Text.R")
source("ReJudge/Text/Lambda.R")

collection.lines <- function(origin) {
  collection.lambda(function() {
    xs <- strsplit(
      contents(origin),
      "\n",
      fixed = TRUE
    )[[1]]
    lapply(
      seq_along(xs),
      function(i) {
        j <- i
        text.lambda(function() xs[[j]])
      }
    )
  })
}
