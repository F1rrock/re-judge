source("ReJudge/Text/Fstring.R")
source("ReJudge/Text/Required.R")
source("ReJudge/Text/Logged.R")
source("ReJudge/Workspace/Env/Lookup.R")

env.variable <- function(name) {
  text.logged(
    text.fstring('fetching %s...', name),
    text.required(
      text.fstring('environment variable %s is not defined', name),
      env.lookup(name)
    )
  )
}
