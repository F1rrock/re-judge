source("ReJudge/Installation/Lambda.R")

installation.pass <- installation.lambda(
  function() {
    paste(
      deparse(
        quote({
          source("ReJudge/Workspace/RStudio/PassPrompt.R")
          source("ReJudge/Text/NonEmpty.R")
          source("ReJudge/Text/Required.R")
          source("ReJudge/Text/Text.R")
          contents(
            text.required(
              "password is required",
              text.nonempty(
                rstudio.passprompt(
                  message = "Enter your ejudge password:"
                )
              )
            )
          )
        })
      ),
      collapse = "\n"
    )
  }
)
