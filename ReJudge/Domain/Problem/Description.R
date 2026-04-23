source("ReJudge/Text/Join.R")
source("ReJudge/Collection/Map.R")
source("ReJudge/Collection/TakeUntil.R")
source("ReJudge/Collection/Filter.R")
source("ReJudge/Dom/Engine/Engine.R")
source("ReJudge/Dom/Element/Text.R")

problem.description <- function(engine) {
  dom <- dom(engine)
  text <- element.text(dom, separator = "\n")
  function(page) {
    text.join(
      "\n",
      collection.map(
        text,
        collection.takeuntil(
          function(e) dom$matches("div#ej-submit-tabs", e),
          collection.filter(
            function(e) !(dom$matches("table.line-table-wb", e)),
            collection.filter(
              function(e) !(dom$matches("style", e)),
              dom$children(
                dom$selection(
                  "div#probNavTaskArea-ins", 
                  dom$root(page)
                )
              )
            )
          )
        )
      )
    )
  }
}
