source("Src/Collection/Lambda.R")
source("Src/Text/Text.R")
source("Src/Text/Lambda.R")

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
