source("ReJudge/Session/Ejudge.R")
source("ReJudge/Session/Presets/Ready.R")
source("ReJudge/Http/Httr/Driver.R")
source("ReJudge/Text/Required.R")
source("ReJudge/Text/NonEmpty.R")
source("ReJudge/Text/Join.R")
source("ReJudge/Workspace/Env/Presets/Variable.R")
source("ReJudge/Workspace/Console/Presets/Message.R")
source("ReJudge/Number/Str.R")
source("ReJudge/Page/Main.R")
source("ReJudge/Dom/Xml2.R")
source("ReJudge/Collection/Map.R")
source("ReJudge/App/Delegate.R")
source("ReJudge/App/Effect.R")
source("ReJudge/Domain/Problems/List.R")

app.problems <- app.delegate(function() {
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
  problems <- problems.list(engine.xml2)
  app.effect(
    console.message(
      text.fstring(
        "Available problems:\n%s",
        text.required(
          "can not fetch problems list",
          text.nonempty(
            text.join(
              ", ",
              problems(
                page(
                  session
                )
              )
            )
          )
        )
      )
    )
  )
})
