source("Src/Text/Regex.R")
source("Src/Text/Payload.R")

token.sid <- function(session) {
  token.plain(
    value = text.regex(
      pattern = 'var SID="([^"]+)"',
      origin  = text.payload(session)
    ),
    expiration = "Inf"
  )
}
