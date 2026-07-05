source("ReJudge/Installation/Lambda.R")

installation.pass <- installation.lambda(
  function() {
    quote({
      pass <- rstudioapi::askForPassword(
        prompt = "Enter your ejudge password:"
      )
      if (is.null(pass)) stop("Password is required")
      pass
    })
  }
)
