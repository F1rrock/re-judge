source("ReJudge/Text/Join.R")
source("ReJudge/Dom/Engine/Engine.R")
source("ReJudge/Dom/Element/Text.R")
source("ReJudge/Collection/Map.R")
source("ReJudge/Collection/Take.R")
source("ReJudge/Collection/DropUntil.R")

report.entire <- function(engine) {
  dom <- dom(engine)
  text <- element.text(dom, separator = " ")
  function(page) {
    text.join(
      "\n",
      collection.map(
        text,
        collection.takeuntil(
          function(e) !dom$matches("div#footer", e),
          collection.dropuntil(
            function(e) !dom$matches("h2", e),
            dom$children(
              dom$selection(
                "div.l13", 
                dom$root(page)
              )
            )
          )
        )
      )
    )
  }
}
