source("Src/Text/Join.R")
source("Src/Dom/Engine/Engine.R")
source("Src/Dom/Element/Table.R")
source("Src/Collection/Map.R")
source("Src/Collection/Take.R")
source("Src/Collection/DropUntil.R")

report.table <- function(engine) {
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
            function(e) dom$matches("table", e),
            dom$children(
              dom$selection(
                "div.l14", 
                dom$root(page)
              )
            )
          )
        )
      )
    )
  }
}
