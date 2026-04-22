source("Src/Text/Text.R")
source("Src/Text/Lambda.R")
source("Src/Text/Regex.R")
source("Src/Text/First.R")
source("Src/Dom/Engine/Engine.R")
source("Src/Dom/Element/Required.R")
source("Src/Dom/Element/First.R")
source("Src/Collection/Map.R")
source("Src/Collection/Filter.R")
source("Src/Collection/Take.R")

run.id <- function(engine) {
  dom <- dom(engine)
  function(page) {
    text.first(
      NA_character_,
      collection.map(
        function(e) dom$txt(e),
        collection.map(
          function(e) element.required("submission was not registered", e),
          collection.map(
            function(ch) element.first(NA_character_, ch),
            collection.map(
              function(e) dom$children(e),
              collection.drop(
                1,
                dom$children(
                  dom$selection(
                    "table.table",
                    dom$selection(
                      "div#ej-submit-tabs", 
                      dom$root(page)
                    )
                  )
                )
              )
            )
          )
        )
      )
    )
  }
}
