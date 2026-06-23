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

problem.attachments <- function(engine) {
  dom <- dom(engine)
  function(page) {
    collection.map(
      function(e) dom$attr("href", e),
      dom$selections(
        "[name='localtest']", 
        dom$root(page)
      )
    )
  }
}
