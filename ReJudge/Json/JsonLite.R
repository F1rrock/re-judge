source("ReJudge/Json/Lambda.R")
source("ReJudge/Json/Parser/Parser.R")
source("ReJudge/Text/Text.R")

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
