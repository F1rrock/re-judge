source("ReJudge/Collection/Collection.R")
source("ReJudge/Number/Number.R")

collection.take <- function(n, xs) {
  structure(
    list(
      count = n,
      origin = xs
    ),
    class = "collection_take"
  )
}

items.collection_take <- function(x) {
  xs <- items(x$origin)
  xs[
    seq_len(
      min(
        length(xs), 
        max(scalar(x$count), 0)
      )
    )
  ]
}
