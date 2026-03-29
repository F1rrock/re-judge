source("Collection/Collection.R")

collection.dropuntil <- function(predicate, xs) {
  structure(
    list(
      predicate = predicate,
      origin = xs
    ),
    class = "collection_dropuntil"
  )
}

items.collection_dropuntil <- function(x) {
  xs <- items(x$origin)
  from <- 1
  while (from <= length(xs) && !x$predicate(xs[[from]])) {
    from <- from + 1
  }
  if (from > length(xs)) base::list() else xs[from:length(xs)]
}
