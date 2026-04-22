source("Src/Text/First.R")
source("Src/Token/Token.R")
source("Src/Token/Plain.R")
source("Src/Collection/Filter.R")
source("Src/Collection/Map.R")
source("Src/Collection/Cookies.R")

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
