source("Src/Dom/Engine/Engine.R")
source("Src/Collection/Map.R")


problems.list <- function(engine) {
  dom <- dom(engine)
  function(page) {
    collection.map(
      dom$txt,
      collection.map(
        function(e) dom$selection("a.tab", e),
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
  }
}
