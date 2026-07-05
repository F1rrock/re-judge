source("ReJudge/Session/Ejudge.R")
source("ReJudge/Session/Presets/Ready.R")
source("ReJudge/Http/Httr/Driver.R")
source("ReJudge/Workspace/RStudio/Current.R")
source("ReJudge/Workspace/Console/Presets/Message.R")
source("ReJudge/Text/Text.R")
source("ReJudge/Text/Default.R")
source("ReJudge/Text/NonEmpty.R")
source("ReJudge/Workspace/Env/Presets/Variable.R")
source("ReJudge/Page/Main.R")
source("ReJudge/Page/Problem.R")
source("ReJudge/Dom/Xml2.R")
source("ReJudge/App/Delegate.R")
source("ReJudge/App/Effect.R")
source("ReJudge/Domain/Submission/Title.R")
source("ReJudge/Domain/Problem/Submissions.R")
source("ReJudge/Domain/Problem/Id.R")

app.submissions <- app.delegate(function() {
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
  app.effect(
    console.message(
      text.default(
        fallback = "there is no submissions for this problem :(",
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
  )
})
