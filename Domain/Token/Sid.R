source("Token/Token.R")
source("Text/Text.R")
source("Text/Regex.R")
source("Text/Html.R")

sid <- function(session) {
  structure(
    list(
      value = text.regex(
        pattern = 'var SID="([^"]+)"',
        origin  = text.html(session)
      )
    ),
    class = "sid"
  )
}
  
value.sid <- function(x) contents(x$value)

expiration.sid <- function(x) Inf
