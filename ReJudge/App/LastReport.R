source("ReJudge/Session/Ejudge.R")
source("ReJudge/Session/Presets/Ready.R")
source("ReJudge/Http/Httr/Driver.R")
source("ReJudge/Workspace/RStudio/Current.R")
source("ReJudge/Text/Text.R")
source("ReJudge/Text/Fstring.R")
source("ReJudge/Text/Default.R")
source("ReJudge/Text/Required.R")
source("ReJudge/Text/NonEmpty.R")
source("ReJudge/Text/Presets/Variable.R")
source("ReJudge/Page/Main.R")
source("ReJudge/Page/Problem.R")
source("ReJudge/Page/Report.R")
source("ReJudge/Dom/Xml2.R")
source("ReJudge/App/App.R")
source("ReJudge/App/Delegate.R")
source("ReJudge/App/Console.R")
source("ReJudge/Domain/Submission/Title.R")
source("ReJudge/Domain/Problem/Id.R")
source("ReJudge/Domain/Run/Last.R")
source("ReJudge/Domain/Report/Table.R")
source("ReJudge/Domain/Report/Title.R")
source("ReJudge/Domain/Report/Details.R")

app.lastreport <- app.delegate(function() {
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
  problem <- page.problem(
    driver = httr.driver,
    address,
    client
  )
  id <- problem.id(engine.xml2)
  lastrun <- run.last(engine.xml2)
  main <- page.main(
    driver = httr.driver, 
    address,
    client
  )
  report <- local({
    table <- report.table(engine.xml2)
    title <- report.title(engine.xml2)
    details <- report.details(engine.xml2)
    page <- local({
      page <- page.report(
        driver = httr.driver,
        address,
        client
      )
      page(
        session, 
        text.required(
          "there is no submissions for this problem :(",
          lastrun(
            problem(
              session,
              id(
                main(session),
                submission.title(rstudio.current)
              )
            )
          )
        )
      )
    })
    text.required(
      "unexpected report structure",
      text.bind(
        page,
        function(page) {
          text.fstring(
            "%s\n%s\n%s",
            title(page),
            table(page),
            details(page)
          )
        }
      )
    )
  })
  app.console(report)
})
