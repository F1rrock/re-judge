source("ReJudge/Collection/TakeUntil.R")
source("ReJudge/Collection/DropUntil.R")
source("ReJudge/Collection/Drop.R")
source("ReJudge/Text/Join.R")
source("ReJudge/Text/Text.R")

problem.example <- function(lines) {
  structure(
    list(
      input = text.join(
        "\n",
        collection.takeuntil(
          function(line) identical(contents(line), "Output"),
          collection.drop(
            1,
            collection.dropuntil(
              function(line) identical(contents(line), "Input"),
              lines
            )
          )
        )
      ),
      output = text.join(
        "\n",
        collection.drop(
          1,
          collection.dropuntil(
            function(line) identical(contents(line), "Output"),
            lines
          )
        )
      )
    ),
    class = "problem_example"
  )
}

input.problem_example <- function(x) x$input
output.problem_example <- function(x) x$output
