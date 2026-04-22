source("Src/Spec/Spec.R")
source("Src/Collection/TakeUntil.R")
source("Src/Collection/DropUntil.R")
source("Src/Collection/Drop.R")
source("Src/Text/Join.R")
source("Src/Text/Text.R")

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
