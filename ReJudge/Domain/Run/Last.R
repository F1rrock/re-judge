source("ReJudge/Text/Join.R")
source("ReJudge/Dom/Engine/Engine.R")
source("ReJudge/Dom/Element/Table.R")
source("ReJudge/Collection/Map.R")
source("ReJudge/Collection/Take.R")
source("ReJudge/Collection/DropUntil.R")

run.last <- function(engine) {
  dom <- dom(engine)
  table <- element.table(dom)
  function(page) {
    text.default(
      fallback = NA_character_,
      origin = text.nonempty(
        dom$txt(
          dom$selection(
            "td.b1", 
            dom$selection(
              "table.table", 
              dom$selection(
                "div#ej-main-submit-tab", 
                dom$root(page)
              )
            )
          )
        )
      )
    )
  }
}
