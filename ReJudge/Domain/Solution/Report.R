source("ReJudge/Text/Join.R")
source("ReJudge/Dom/Engine/Engine.R")
source("ReJudge/Dom/Element/Table.R")
source("ReJudge/Dom/Element/Text.R")
source("ReJudge/Collection/Map.R")
source("ReJudge/Collection/DropUntil.R")

solution.report <- function(engine) {
  dom <- dom(engine)
  table <- element.table(dom)
  text <- element.text(dom, separator = "\n")
  function(page) {
    text.join(
      "\n",
      collection.map(
        table,
        collection.dropuntil(
          function(e) dom$matches("table.table", e),
          dom$children(
            dom$selection(
              "div.l14", 
              dom$root(page)
            )
          )
        )
      )
    )
  }
}
