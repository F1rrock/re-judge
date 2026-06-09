source("ReJudge/Text/Join.R")
source("ReJudge/Dom/Engine/Engine.R")
source("ReJudge/Dom/Element/Table.R")
source("ReJudge/Collection/Map.R")
source("ReJudge/Collection/Take.R")
source("ReJudge/Collection/DropUntil.R")

problem.submissions <- function(engine) {
  dom <- dom(engine)
  table <- element.table(dom)
  function(page) {
    text.join(
      "\n",
      collection.map(
        table,
        collection.take(
          1,
          collection.dropuntil(
            function(e) dom$matches("table.table", e),
            dom$children(
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
