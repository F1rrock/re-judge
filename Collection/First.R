source("Collection/Collection.R")

collection.first <- function(default, xs) {
  xs <- items(xs)
  if (length(xs) == 0) {
    return(default)
  }
  xs[[1]]
}
