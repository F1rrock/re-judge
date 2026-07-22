source("ReJudge/Session/Ejudge.R")
source("ReJudge/Session/Presets/Ready.R")
source("ReJudge/Http/Httr/Driver.R")
source("ReJudge/Workspace/RStudio/Current.R")
source("ReJudge/Workspace/Env/Presets/Variable.R")
source("ReJudge/Workspace/Console/Presets/Message.R")
source("ReJudge/Workspace/RStudio/Prompt.R")
source("ReJudge/Workspace/Env/Assign.R")
source("ReJudge/Text/Memo.R")
source("ReJudge/Text/Delegate.R")
source("ReJudge/Text/Fstring.R")
source("ReJudge/Text/Palette.R")
source("ReJudge/Text/NonEmpty.R")
source("ReJudge/Text/Required.R")
source("ReJudge/Text/Then.R")
source("ReJudge/Effect/Effect.R")
source("ReJudge/App/Effect.R")

app.switchcontest <- app.delegate(function() {
  address <- env.variable("BASE_URL")
  client <- env.variable("CLIENT_PATH")
  contest <- text.memo(
    text.required(
      "Contest ID is required",
      text.nonempty(
        rstudio.prompt(
          "Switch Contest",
          "Enter new contest ID:"
        )
      )
    )
  )
  session <- local({
    auth <- session.ejudge(
      driver = httr.driver,
      address,
      client
    )
    session.ready(
      auth(
        login = env.variable("LOGIN"),
        pass = env.variable("PASSWORD"),
        contest = contest
      )
    )
  })
  app.effect(
    console.message(
      text.delegate(
        function() {
          realize(
            env.assign(
              "CONTEST_ID",
              text.required(
                text.fstring(
                  "%s\n%s\n",
                  "could not authorize with ejudge.",
                  "try again later with correct credentials"
                ),
                text.then(
                  text.then(
                    text.nonempty(
                      text.token(
                        token.ejsid(session)
                      )
                    ),
                    text.nonempty(
                      text.token(
                        token.sid(session)
                      )
                    )
                  ),
                  contest
                )
              )
            )
          )
          text.green("Changed successfully!")
        }
      )
    )
  )
})
