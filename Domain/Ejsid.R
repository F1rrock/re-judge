source("Text/Text.R")
source("Session/Session.R")
source("Func/First.R")

ejsid <- function(s) {
  structure(
    list(
      session = s
    ),
    class = "ejsid"
  )
}

contents.ejsid <- function(x) {
  first(
    default = NA_character_,
    lapply(
      Filter(
        function(ck) identical(ck$name, "EJSID"),
        cookies(x$session)
      ),
      function(ck) ck$value
    )
  )
}
