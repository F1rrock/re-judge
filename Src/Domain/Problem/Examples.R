source("Src/Collection/Lines.R")
source("Src/Collection/DropUntil.R")
source("Src/Collection/Drop.R")
source("Src/Collection/SplitWhen.R")
source("Src/Text/Text.R")
source("Src/Text/First.R")
source("Src/Domain/Problem/Example.R")

problem.examples <- function(description) {
  collection.map(
    function(block) problem.example(block),
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
