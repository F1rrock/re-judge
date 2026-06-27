source("ReJudge/Collection/Lines.R")
source("ReJudge/Collection/DropUntil.R")
source("ReJudge/Collection/Drop.R")
source("ReJudge/Collection/SplitWhen.R")
source("ReJudge/Text/Text.R")
source("ReJudge/Text/First.R")
source("ReJudge/Spec/Normalized.R")
source("ReJudge/Domain/Problem/Example.R")

problem.examples <- function(description) {
  collection.map(
    function(block) {
      spec.normalized(
        problem.example(block)
      )
    },
    collection.filter(
      function(block) {
        identical(
          contents(
            text.first(default = "", block)
          ),
          "Input"
        )
      },
      collection.filter(
        function(block) length(items(block)) > 0,
        collection.splitwhen(
          function(line) identical(contents(line), "Input"),
          collection.drop(
            1,
            collection.dropuntil(
              function(line) identical(contents(line), "Examples"),
              collection.lines(description)
            )
          )
        )
      )
    )
  )
}
