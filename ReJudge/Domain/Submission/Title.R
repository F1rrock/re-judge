source("ReJudge/Text/Required.R")
source("ReJudge/Text/Regex.R")
source("ReJudge/Text/First.R")
source("ReJudge/Collection/Lines.R")
source("ReJudge/Collection/Map.R")
source("ReJudge/Collection/Filter.R")

submission.title <- function(file) {
  text.required(
    "expected line like '# problem: <problem>'",
    text.first(
      NA_character_,
      collection.filter(
        function(x) !is.na(contents(x)),
        collection.map(
          function(l) {
            text.regex(
              "^# problem: \\s*([A-Za-z][A-Za-z0-9]*)\\s*$",
              l
            )
          },
          collection.lines(
            text.lambda(
              function() {
                ReJudge(
                  file.required(
                    "required submission file path is not defined",
                    file
                  )
                )
              }
            )
          )
        )
      )
    )
  )
}
