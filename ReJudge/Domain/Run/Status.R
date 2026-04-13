source("ReJudge/Json/Parser/Parser.R")
source("ReJudge/Collection/Map.R")
source("ReJudge/Collection/Filter.R")
source("ReJudge/Collection/Pairs.R")
source("ReJudge/Status/First.R")
source("ReJudge/Domain/Run/State/Testing.R")
source("ReJudge/Domain/Run/State/Completed.R")
source("ReJudge/Domain/Run/State/Undefined.R")

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
