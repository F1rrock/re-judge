source("ReJudge/Session/Ejudge.R")
source("ReJudge/Session/Presets/Ready.R")
source("ReJudge/Http/Httr/Driver.R")
source("ReJudge/Text/Default.R")
source("ReJudge/Text/Bind.R")
source("ReJudge/Text/NonEmpty.R")
source("ReJudge/Text/Join.R")
source("ReJudge/Workspace/Env/Presets/Variable.R")
source("ReJudge/Workspace/Console/Presets/Message.R")
source("ReJudge/Page/Main.R")
source("ReJudge/Dom/Xml2.R")
source("ReJudge/App/Delegate.R")
source("ReJudge/App/Effect.R")
source("ReJudge/Domain/Problems/Solved.R")

app.solved <- app.delegate(function() {
  address <- env.variable("BASE_URL")
  client <- env.variable("CLIENT_PATH")
  session <- local({
    auth <- session.ejudge(
      driver  = httr.driver,
      address,
      client
    )
    session.ready(
      auth(
        login = env.variable("LOGIN"),
        pass = env.variable("PASSWORD"),
        contest = env.variable("CONTEST_ID")
      )
    )
  })
  page <- page.main(
    driver = httr.driver,
    address,
    client
  )
  solved <- problems.solved(engine.xml2)
  app.effect(
    console.message(
      text.default(
        fallback = "There is no solved problems :(\n",
        origin = text.bind(
          text.nonempty(
            text.join(
              ", ",
              solved(
                page(
                  session
                )
              )
            )
          ),
          function(s) text.fstring("Solved problems:\n%s", s)
        )
      )
    )
  )
})
