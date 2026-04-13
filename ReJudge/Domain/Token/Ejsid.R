source("ReJudge/Text/First.R")
source("ReJudge/Token/Token.R")
source("ReJudge/Token/Plain.R")
source("ReJudge/Collection/Filter.R")
source("ReJudge/Collection/Map.R")
source("ReJudge/Collection/Cookies.R")

token.ejsid <- function(session) {
  origin <- collection.filter(
    function(ck) identical(ck$name, "EJSID"),
    collection.cookies(session)
  )
  token.plain(
    value = text.first(
      default = NA_character_,
      collection.map(
        function(ck) ck$value,
        origin
      )
    ),
    expiration = text.first(
      default = NA_character_,
      collection.map(
        function(ck) ck$expiration,
        origin
      )
    )
  )
}
