source("Src/Json/Lambda.R")
source("Src/Json/Parser/Parser.R")
source("Src/Text/Text.R")

parser.jsonlite <- structure(
  list(),
  class = "parser_jsonlite"
)

doc.parser_jsonlite <- function(x) {
  function(page) {
    json.lambda(
      function() {
        jsonlite::fromJSON(contents(page))
      }
    )
  }
}
