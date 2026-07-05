source("ReJudge/Installation/Lambda.R")

installation.contest <- installation.lambda(
  function() {
    quote({
      contest <- rstudioapi::showPrompt(
        title = "Contest ID",
        message = "Enter contest ID:",
        default = "1"
      )
      if (is.null(contest) || contest == "") stop("Contest ID is required")
      contest
    })
  }
)
