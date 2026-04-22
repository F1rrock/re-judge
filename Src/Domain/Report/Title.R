source("Src/Text/Join.R")
source("Src/Dom/Engine/Engine.R")
source("Src/Dom/Element/Text.R")
source("Src/Collection/Map.R")
source("Src/Collection/Take.R")
source("Src/Collection/DropUntil.R")

report.title <- function(engine) {
  dom <- dom(engine)
  text <- element.text(dom)
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
