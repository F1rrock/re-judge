source("ReJudge/Dom/Engine/Engine.R")
source("ReJudge/Collection/Map.R")
source("ReJudge/Collection/Filter.R")


problems.solved <- function(engine) {
  dom <- dom(engine)
  function(page) {
    collection.map(
      dom$txt,
      collection.map(
        function(e) dom$selection("a.tab", e),
        collection.filter(
          function(e) dom$matches("div.nProbOk", e),
          dom$children(
            dom$selection(
              "ul.nTopNavList",
              dom$selection(
                "tr#probNavTopList", 
                dom$root(page)
              )
            )
          )
        )
      )
    )
  }
}
