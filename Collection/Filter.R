source("Collection/Collection.R")

collection.filter <- function(f, xs) {
  structure(
    list(
      predicate = f,
      origin = xs
    ),
    class = "collection_filter"
  )
}

items.collection_filter <- function(x) {
  Filter(
    x$predicate,
    items(x$origin)
  )
}
