source("Collection/Collection.R")

collection.cookies <- function(session) {
  structure(
    list(
      session = s
    ),
    class = "collection_cookies"
  )
}

items.collection_cookies <- function(x) {
  cookies(x$session)
}
