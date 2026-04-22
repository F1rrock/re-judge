source("Src/Text/Text.R")
source("Src/Text/Lambda.R")
source("Src/Text/Trimmed.R")

text.asserted <- function(actual, expected, message) {
  text.lambda(function() {
    actual <- contents(
      text.trimmed(
        actual
      )
    )
    expected <- contents(
      text.trimmed(
        expected
      )
    )
    if (identical(actual, expected)) actual else stop(message)
  })
}
