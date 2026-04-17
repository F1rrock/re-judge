source("ReJudge/Session/Ejudge.R")
source("ReJudge/Session/Presets/Ready.R")
source("ReJudge/Http/Httr/Driver.R")
source("ReJudge/Text/Required.R")
source("ReJudge/Text/NonEmpty.R")
source("ReJudge/Text/Join.R")
source("ReJudge/Text/Presets/Variable.R")
source("ReJudge/Number/Str.R")
source("ReJudge/Page/Main.R")
source("ReJudge/Dom/Xml2.R")
source("ReJudge/Collection/Map.R")
source("ReJudge/App/Delegate.R")
source("ReJudge/App/Console.R")
source("ReJudge/Domain/Problems/List.R")

app.problems <- app.delegate(function() {
  address <- text.variable("BASE_URL")
  client <- text.variable("CLIENT_PATH")
  session <- local({
    auth <- session.ejudge(
      driver  = httr.driver,
      address,
      client
    )
    session.ready(
      auth(
        login = text.variable("LOGIN"),
        pass = text.variable("PASSWORD"),
        contest = text.variable("CONTEST_ID")
      )
    )
  })
  page <- page.main(
    driver = httr.driver,
    address,
    client
  )
  problems <- problems.list(engine.xml2)
  app.console(
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
})
