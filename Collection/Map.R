source("Collection/Collection.R")

collection.map <- function(f, xs) {
  structure(
    list(
      f = f,
      origin = xs
    ),
    class = "collection_map"
  )
}

items.collection_map <- function(x) {
  lapply(
    items(x$origin),
    x$f
  )
}
