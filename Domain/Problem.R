source("Text/Join.R")
source("Collection/Map.R")
source("Collection/TakeUntil.R")
source("Collection/DropUntil.R")
source("Collection/Drop.R")
source("Dom/Engine/Engine.R")

problem <- function(engine) {
  dom  <- dom(engine)
  function(page) {
    text.join(
      "\n",
      collection.map(
        dom$txt,
        collection.takeuntil(
          function(e) dom$matches("div#ej-submit-tabs", e),
          collection.drop(
            1,
            collection.dropuntil(
              function(e) dom$matches("table.line-table-wb", e),
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
