source("ReJudge/Installation/Lambda.R")

installation.login <- installation.lambda(
  function() {
    paste(
      deparse(
        quote({
          source("ReJudge/Workspace/RStudio/Prompt.R")
          source("ReJudge/Text/NonEmpty.R")
          source("ReJudge/Text/Required.R")
          source("ReJudge/Text/Text.R")
          contents(
            text.required(
              "login is required",
              text.nonempty(
                rstudio.prompt(
                  title = "Ejudge Login",
                  message = "Enter your ejudge login:",
                  default = ""
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
