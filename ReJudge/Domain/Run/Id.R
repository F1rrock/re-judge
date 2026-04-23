source("ReJudge/Text/Text.R")
source("ReJudge/Text/Lambda.R")
source("ReJudge/Text/Regex.R")
source("ReJudge/Text/First.R")
source("ReJudge/Dom/Engine/Engine.R")
source("ReJudge/Dom/Element/Required.R")
source("ReJudge/Dom/Element/First.R")
source("ReJudge/Collection/Map.R")
source("ReJudge/Collection/Filter.R")
source("ReJudge/Collection/Take.R")

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
