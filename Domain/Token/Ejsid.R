source("Token/Token.R")
source("Collection/Filter.R")
source("Collection/Map.R")
source("Collection/First.R")
source("Collection/Cookies.R")

ejsid <- function(session) {
  structure(
    list(
      origin = collection.filter(
        function(ck) identical(ck$name, "EJSID"),
        collection.cookies(session)
      )
    ),
    class = "ejsid"
  )
}

value.ejsid <- function(x) {
  collection.first(
    default = NA_character_,
    collection.map(
      function(ck) ck$value,
      x$origin
    )
  )
}

expiration.ejsid <- function(x) {
  collection.first(
    default = NA_character_,
    collection.map(
      function(ck) ck$expiration,
      x$origin
    )
  )
}
