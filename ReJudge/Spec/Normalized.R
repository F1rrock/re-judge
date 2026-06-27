source("ReJudge/Spec/Spec.R")
source("ReJudge/Text/Text.R")

spec.normalized <- function(x) {
  structure(
    list(
      origin = x
    ),
    class = "spec_normalized"
  )
}

input.spec_normalized <- function(x) {
  unlist(
    strsplit(
      gsub(
        "^\\s+|\\s+$", 
        "", 
        contents(
          input(
            x$origin
          )
        )
      ), 
      "\\s*\\n\\s*"
    )
  )
}

output.spec_normalized <- function(x) output(x$origin)
