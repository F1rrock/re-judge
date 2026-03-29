source("Collection/Collection.R")

collection.lambda <- function(f) {
  structure(
    list(
      callback = f
    ),
    class = "collection_lambda"
  )
}

items.collection_lambda <- function(x) x$callback()
