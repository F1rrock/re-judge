source("ReJudge/Text/Join.R")
source("ReJudge/Dom/Engine/Engine.R")
source("ReJudge/Dom/Element/Text.R")
source("ReJudge/Collection/Map.R")
source("ReJudge/Collection/Take.R")
source("ReJudge/Collection/DropUntil.R")

report.title <- function(engine) {
  dom <- dom(engine)
  text <- element.text(dom, separator = " ")
  function(page) {
    text.join(
      "\n",
      collection.map(
        text,
        collection.take(
          1,
          collection.dropuntil(
            function(e) dom$matches("h2", e),
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
