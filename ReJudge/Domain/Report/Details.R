source("ReJudge/Text/Join.R")
source("ReJudge/Dom/Engine/Engine.R")
source("ReJudge/Dom/Element/Text.R")
source("ReJudge/Collection/Map.R")
source("ReJudge/Collection/Drop.R")

report.details <- function(engine) {
  dom <- dom(engine)
  text <- element.text(dom, separator = "\n")
  function(page) {
    text.join(
      "\n",
      collection.map(
        text,
        collection.drop(
          1,
          dom$selections(
            "pre",
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
