source("ReJudge/Text/Lambda.R")

rstudio.prompt <- function(title, message, default = "") {
  text.lambda(
    function() {
      prompt <- rstudioapi::showPrompt(
        title = title,
        message = message,
        default = default
      )
      if (is.null(prompt)) return(NA_character_)
      prompt
    }
  )
}
