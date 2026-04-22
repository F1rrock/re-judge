source("Src/Text/Join.R")
source("Src/Number/Str.R")
source("Src/Collection/Map.R")
source("Src/Collection/TakeUntil.R")
source("Src/Collection/Filter.R")
source("Src/Dom/Engine/Engine.R")
source("Src/Dom/Element/Text.R")

problem.languages <- function(engine) {
  dom <- dom(engine)
  function(page) {
    collection.map(
      function(e) dom$attr("value", e),
      collection.drop(
        1,
        dom$children(
          element.required(
            "no available languages for this problem",
            dom$selection(
              "select[name='lang_id']", 
              dom$root(page)
            )
          )
        )
      )
    )
  }
}
