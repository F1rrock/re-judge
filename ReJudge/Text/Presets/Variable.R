source("ReJudge/Text/Text.R")
source("ReJudge/Text/Fstring.R")
source("ReJudge/Text/Required.R")
source("ReJudge/Text/Env.R")
source("ReJudge/Text/Logged.R")

text.variable <- function(name) {
  text.logged(
    text.fstring('fetching %s...', name),
    text.required(
      text.fstring('environment variable %s is not defined', name),
      text.env(name)
    )
  )
}
