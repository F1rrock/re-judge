source("Src/Text/Required.R")
source("Src/Text/Regex.R")
source("Src/Text/First.R")
source("Src/Number/Str.R")
source("Src/Collection/Lines.R")
source("Src/Collection/Map.R")
source("Src/Collection/Filter.R")

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
