source("Src/Text/Text.R")
source("Src/Text/Lambda.R")
source("Src/Text/Regex.R")
source("Src/Text/First.R")
source("Src/Dom/Engine/Engine.R")
source("Src/Collection/Map.R")
source("Src/Collection/Filter.R")

problem.id <- function(engine) {
  dom <- dom(engine)
  function(page, title) {
    text.first(
      NA_character_,
      collection.map(
        function(r) text.regex("prob_id=([0-9]+)", r),
        collection.map(
          function(e) dom$attr("href", e),
          collection.filter(
            function(e) {
              identical(
                contents(dom$txt(e)), 
                contents(title)
              )
            },
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
        )
      )
    )
  }
}
