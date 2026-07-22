source("ReJudge/Session/Ejudge.R")
source("ReJudge/Session/Presets/Ready.R")
source("ReJudge/Http/Httr/Driver.R")
source("ReJudge/Workspace/RStudio/Current.R")
source("ReJudge/Workspace/Env/Presets/Variable.R")
source("ReJudge/Workspace/Console/Presets/Message.R")
source("ReJudge/Workspace/RStudio/Prompt.R")
source("ReJudge/Workspace/RStudio/PassPrompt.R")
source("ReJudge/Workspace/Env/Assign.R")
source("ReJudge/Text/Text.R")
source("ReJudge/Text/Memo.R")
source("ReJudge/Text/Delegate.R")
source("ReJudge/Text/Fstring.R")
source("ReJudge/Text/Palette.R")
source("ReJudge/Text/NonEmpty.R")
source("ReJudge/Text/Required.R")
source("ReJudge/Text/Then.R")
source("ReJudge/Effect/Effect.R")
source("ReJudge/Effect/Then.R")
source("ReJudge/Effect/Lambda.R")
source("ReJudge/App/Effect.R")

app.credentials <- app.delegate(function() {
  address <- env.variable("BASE_URL")
  client <- env.variable("CLIENT_PATH")
  login <- text.memo(
    text.required(
      "Login is required",
      text.nonempty(
        rstudio.prompt(
          title = "Ejudge Login",
          message = "Enter your ejudge login:",
          default = ""
        )
      )
    )
  )
  pass <- text.memo(
    text.required(
      "Password is required",
      text.nonempty(
        rstudio.passprompt(
          message = "Enter your ejudge password:"
        )
      )
    )
  )
  contest <- text.memo(
    text.required(
      "Contest ID is required",
      text.nonempty(
        rstudio.prompt(
          title = "Contest ID",
          message = "Enter contest ID:",
          default = "1"
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
      auth(login, pass, contest)
    )
  })
  app.effect(
    console.message(
      text.delegate(
        function() {
          realize(
            effect.then(
              effect.lambda(
                function() {
                  contents(
                    text.required(
                      text.fstring(
                        "%s\n%s\n",
                        "could not authorize with ejudge.",
                        "try again later with correct credentials"
                      ),
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
                      )
                    )
                  )
                }
              ),
              effect.then(
                env.assign("LOGIN", login),
                effect.then(
                  env.assign("PASSWORD", pass),
                  env.assign("CONTEST_ID", contest)
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
