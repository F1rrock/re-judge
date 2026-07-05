source("ReJudge/Workspace/Console/Presets/Message.R")
source("ReJudge/Workspace/RStudio/Prompt.R")
source("ReJudge/Workspace/Env/Assign.R")
source("ReJudge/Text/Palette.R")
source("ReJudge/Text/NonEmpty.R")
source("ReJudge/Text/Required.R")
source("ReJudge/Effect/Then.R")
source("ReJudge/App/Effect.R")

app.switchcontest <- app.effect(
  effect.then(
    env.assign(
      "CONTEST_ID",
      text.required(
        "Contest ID is required",
        text.nonempty(
          rstudio.prompt(
            "Switch Contest",
            "Enter new contest ID:",
          )
        )
      )
    ),
    console.message(
      text.green(
        "Changed successfully"
      )
    )
  )
)
