source("ReJudge/Text/Text.R")
source("ReJudge/Text/Lambda.R")

env.lookup<- function(name) {
  text.lambda(
    function() {
      dotenv::load_dot_env()
      Sys.getenv(
        contents(name),
        unset = NA_character_
      )
    }
  )
}
