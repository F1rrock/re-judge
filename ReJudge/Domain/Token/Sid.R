source("ReJudge/Text/Plain.R")
source("ReJudge/Text/Regex.R")
source("ReJudge/Text/Payload.R")

token.sid <- function(session) {
  token.plain(
    value = text.regex(
      pattern = 'var SID="([^"]+)"',
      origin  = text.payload(session)
    ),
    expiration = "Inf"
  )
}
