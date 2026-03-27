source("Text/Regex.R")
source("Text/Html.R")

sid <- function(session) {
  text.regex(
    pattern = 'var SID="([^"]+)"',
    origin = text.html(session)
  )
}
