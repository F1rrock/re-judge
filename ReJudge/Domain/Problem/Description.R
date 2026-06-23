source("ReJudge/Text/Default.R")
source("ReJudge/Text/Bind.R")
source("ReJudge/Text/Fstring.R")
source("ReJudge/Text/Empty.R")
source("ReJudge/Text/Join.R")
source("ReJudge/Collection/Map.R")
source("ReJudge/Collection/TakeUntil.R")
source("ReJudge/Collection/Filter.R")
source("ReJudge/Dom/Engine/Engine.R")
source("ReJudge/Dom/Element/Text.R")

problem.description <- function(engine) {
  dom <- dom(engine)
  text <- element.text(dom, separator = "\n")
  function(page) {
    text.join(
      "\n",
      collection.map(
        function(e) {
          text.fstring(
            "%s%s%s",
            text(e), 
            text.default(
              fallback = text.empty,
              origin = text.bind(
                dom$attr("href", e), 
                function(x) text.fstring("[%s]", x)
              )
            ),
            text.join(
              "",
              collection.map(
                function(e) {
                  text.default(
                    fallback = text.empty,
                    origin = text.bind(
                      dom$attr("href", e), 
                      function(x) text.fstring("[%s]", x)
                    )
                  )
                },
                dom$selections("[href]", e)
              )
            )
          )
        },
        collection.takeuntil(
          function(e) dom$matches("div#ej-submit-tabs", e),
          collection.filter(
            function(e) !(dom$matches("table.line-table-wb", e)),
            collection.filter(
              function(e) !(dom$matches("style", e)),
              collection.filter(
                function(e) !(dom$matches("br", e)),
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
    )
  }
}
