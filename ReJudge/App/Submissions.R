source("ReJudge/Session/Ejudge.R")
source("ReJudge/Session/Presets/Ready.R")
source("ReJudge/Http/Httr/Driver.R")
source("ReJudge/Workspace/RStudio/Current.R")
source("ReJudge/Text/Text.R")
source("ReJudge/Text/Default.R")
source("ReJudge/Text/NonEmpty.R")
source("ReJudge/Text/Presets/Variable.R")
source("ReJudge/Page/Main.R")
source("ReJudge/Page/Problem.R")
source("ReJudge/Dom/Xml2.R")
source("ReJudge/App/App.R")
source("ReJudge/App/Delegate.R")
source("ReJudge/App/Console.R")
source("ReJudge/Domain/Submission/Title.R")
source("ReJudge/Domain/Problem/Submissions.R")
source("ReJudge/Domain/Problem/Id.R")

app.submissions <- app.delegate(function() {
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
  submissions <- problem.submissions(engine.xml2)
  main <-  page.main(
    driver = httr.driver, 
    address,
    client
  )
  app.console(
    text.default(
      fallback = "there is no submissions for this problem",
      origin = text.nonempty(
        submissions(
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
