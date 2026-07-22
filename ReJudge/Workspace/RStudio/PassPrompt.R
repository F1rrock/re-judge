source("ReJudge/Text/Lambda.R")

rstudio.passprompt <- function(message) {
  text.lambda(
    function() {
      prompt <- rstudioapi::askForPassword(
        prompt = message
      )
      if (is.null(prompt)) return(NA_character_)
      prompt
    }
  )
}
