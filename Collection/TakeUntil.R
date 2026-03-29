source("Collection/Collection.R")

collection.takeuntil <- function(predicate, xs) {
  structure(
    list(
      predicate = predicate,
      origin = xs
    ),
    class = "collection_takeuntil"
  )
}

items.collection_takeuntil <- function(x) {
  xs <- items(x$origin)
  to <- 1
  while (to <= length(xs) && !x$predicate(xs[[to]])) {
    to <- to + 1
  }
  xs[seq_len(to - 1)]
}
