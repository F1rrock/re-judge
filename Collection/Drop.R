source("Collection/Collection.R")

collection.drop <- function(k, xs) {
  structure(
    list(
      count = k,
      origin = xs
    ),
    class = "collection_drop"
  )
}

items.collection_drop <- function(x) {
  xs <- items(x$origin)
  k  <- x$count
  if (k <= 0) return(xs)
  if (k >= length(xs)) return(base::list())
  xs[(k + 1):length(xs)]
}
