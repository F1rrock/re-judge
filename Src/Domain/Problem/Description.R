source("Src/Text/Join.R")
source("Src/Collection/Map.R")
source("Src/Collection/TakeUntil.R")
source("Src/Collection/Filter.R")
source("Src/Dom/Engine/Engine.R")
source("Src/Dom/Element/Text.R")

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
