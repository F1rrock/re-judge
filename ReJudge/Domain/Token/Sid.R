source("ReJudge/Text/Regex.R")
source("ReJudge/Text/Payload.R")

token.sid <- function(session) {
  token.plain(
    value = text.regex(
      pattern = '^(?!0{16}$)(.+)$',
      origin  = text.regex(
        pattern = 'var SID="([^"]+)"',
        origin  = text.payload(session)
      )
    ),
    expiration = "Inf"
  )
}
