source("Src/Session/Ejudge.R")
source("Src/Session/Presets/Ready.R")
source("Src/Http/Httr/Driver.R")
source("Src/Workspace/RStudio/Current.R")
source("Src/Text/Text.R")
source("Src/Text/Required.R")
source("Src/Text/NonEmpty.R")
source("Src/Text/Presets/Variable.R")
source("Src/Number/Str.R")
source("Src/Page/Main.R")
source("Src/Page/Problem.R")
source("Src/Dom/Xml2.R")
source("Src/App/App.R")
source("Src/App/Delegate.R")
source("Src/App/Console.R")
source("Src/Domain/Submission/Title.R")
source("Src/Domain/Problem/Description.R")
source("Src/Domain/Problem/Id.R")

app.problem <- app.delegate(function() {
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
  page <- page.problem(
    driver = httr.driver,
    address,
    client
  )
  id <- problem.id(engine.xml2)
  description <- problem.description(engine.xml2)
  main <-  page.main(
    driver  = httr.driver, 
    address,
    client
  )
  app.console(
    text.required(
      "can not fetch problem description",
      text.nonempty(
        description(
          page(
            session,
            id(
              main(session),
              submission.title(rstudio.current)
            )
          )
        )
      )
    )
  )
})
