source("Src/Json/Parser/Parser.R")
source("Src/Collection/Map.R")
source("Src/Collection/Filter.R")
source("Src/Collection/Pairs.R")
source("Src/Status/First.R")
source("Src/Domain/Run/State/Testing.R")
source("Src/Domain/Run/State/Completed.R")
source("Src/Domain/Run/State/Undefined.R")

run.status <- function(parser) {
  doc <- doc(parser)
  variants <- list(x = run.testing, z = run.completed)
  function(page) {
    status.first(
      run.undefined,
      collection.filter(
        function(p) !(is.null(p)),
        collection.map(
          function(p) variants[[p$key]],
          collection.filter(
            function(p) identical(p$value, as.integer(1)),
            collection.pairs(doc(page))
          )
        )
      )
    )
  }
}
