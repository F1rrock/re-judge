source("Src/Session/Ejudge.R")
source("Src/Session/Presets/Ready.R")
source("Src/Http/Httr/Driver.R")
source("Src/Text/Required.R")
source("Src/Text/NonEmpty.R")
source("Src/Text/Join.R")
source("Src/Text/Presets/Variable.R")
source("Src/Number/Str.R")
source("Src/Page/Main.R")
source("Src/Dom/Xml2.R")
source("Src/Collection/Map.R")
source("Src/App/Delegate.R")
source("Src/App/Console.R")
source("Src/Domain/Problems/List.R")

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
