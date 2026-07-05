source("ReJudge/Installation/Lambda.R")

installation.login <- installation.lambda(
  function() {
    quote({
      login <- rstudioapi::showPrompt(
        title = "Ejudge Login",
        message = "Enter your ejudge login:",
        default = ""
      )
      if (is.null(login) || login == "") stop("Login is required")
      login
    })
  }
)
