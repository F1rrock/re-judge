source("ReJudge/Collection/Collection.R")
source("ReJudge/Json/Json.R")

collection.pairs <- function(xs) {
  structure(
    list(origin = xs),
    class = "collection_pairs"
  )
}

items.collection_pairs <- function(x) {
  xs <- fields(x$origin)
  n  <- names(xs)
  lapply(
    seq_along(xs),
    function(i) {
      j <- i
      list(key = n[[j]], value = xs[[j]])
    }
  )
}
