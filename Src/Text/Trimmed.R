source("Src/Text/Text.R")
source("Src/Text/Lambda.R")

text.trimmed <- function(x) {
  text.lambda(
    function() {
      trimws(
        contents(x)
      )
    }
  )
}
