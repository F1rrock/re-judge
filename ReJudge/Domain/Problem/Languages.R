source("ReJudge/Text/Join.R")
source("ReJudge/Number/Str.R")
source("ReJudge/Collection/Map.R")
source("ReJudge/Collection/TakeUntil.R")
source("ReJudge/Collection/Filter.R")
source("ReJudge/Dom/Engine/Engine.R")
source("ReJudge/Dom/Element/Text.R")

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
