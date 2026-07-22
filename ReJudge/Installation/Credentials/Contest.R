source("ReJudge/Installation/Lambda.R")

installation.contest <- installation.lambda(
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
              "contest id is required",
              text.nonempty(
                rstudio.prompt(
                  title = "Contest ID",
                  message = "Enter contest ID:",
                  default = "1"
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
