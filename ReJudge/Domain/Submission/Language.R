source("ReJudge/Text/Required.R")
source("ReJudge/Text/Regex.R")
source("ReJudge/Text/First.R")
source("ReJudge/Number/Str.R")
source("ReJudge/Collection/Lines.R")
source("ReJudge/Collection/Map.R")
source("ReJudge/Collection/Filter.R")

submission.language <- function(file) {
  number.str(
    text.required(
      "expected line like '# language: <serial number in selector>'",
      text.first(
        NA_character_,
        collection.filter(
          function(x) !is.na(contents(x)),
          collection.map(
            function(l) {
              text.regex(
                "^# language: \\s*([0-9]*)\\s*$",
                l
              )
            },
            collection.lines(
              text.lambda(
                function() {
                  src(
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
  )
}
