source("Text/Text.R")
source("Collection/Filter.R")
source("Collection/Map.R")
source("Collection/First.R")
source("Collection/Cookies.R")

ejsid <- function(session) {
  structure(
    list(
      origin = collection.map(
        function(ck) ck$value,
        collection.filter(
          function(ck) identical(ck$name, "EJSID"),
          collection.cookies(session)
        )
      )
    ),
    class = "ejsid"
  )
}

contents.ejsid <- function(x) {
  collection.first(
    default = NA_character_,
    x$origin
  )
}
