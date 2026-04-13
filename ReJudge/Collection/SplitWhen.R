source("ReJudge/Collection/Collection.R")
source("ReJudge/Collection/Lambda.R")

collection.splitwhen <- function(predicate, xs) {
  structure(
    list(
      predicate = predicate,
      origin = xs
    ),
    class = "collection_splitwhen"
  )
}

items.collection_splitwhen <- function(x) {
  xs <- items(x$origin)
  if (length(xs) == 0) return(base::list())
  groups <- pmax(
    1,
    cumsum(
      vapply(
        xs,
        x$predicate,
        logical(1)
      )
    )
  )
  lapply(
    split(xs, groups),
    function(chunk) {
      collection.lambda(local({
        ys <- chunk
        function() ys
      }))
    }
  )
}
