source("ReJudge/Installation/Installation.R")
source("ReJudge/Installation/Lambda.R")

installation.interactive <- function(auth, ...) {
  installation.lambda(
    function() {
      code(
        auth(
          quote(
            rstudioapi::showPrompt(
              title = "Ejudge Login",
              message = "Enter your ejudge login:",
              default = ""
            )
          ), 
          quote(
            rstudioapi::askForPassword(
              prompt = "Enter your ejudge password:"
            )
          ), 
          quote(
            rstudioapi::showPrompt(
              title = "Contest ID",
              message = "Enter contest ID:",
              default = "1"
            )
          ),
          ...
        )
      )
    }
  )
}
