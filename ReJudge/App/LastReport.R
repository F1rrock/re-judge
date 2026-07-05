source("ReJudge/Session/Ejudge.R")
source("ReJudge/Session/Presets/Ready.R")
source("ReJudge/Http/Httr/Driver.R")
source("ReJudge/Workspace/RStudio/Current.R")
source("ReJudge/Workspace/Env/Presets/Variable.R")
source("ReJudge/Workspace/Console/Presets/Message.R")
source("ReJudge/Text/Text.R")
source("ReJudge/Text/Fstring.R")
source("ReJudge/Text/Default.R")
source("ReJudge/Text/Required.R")
source("ReJudge/Text/NonEmpty.R")
source("ReJudge/Text/Presets/Paragraph.R")
source("ReJudge/Page/Main.R")
source("ReJudge/Page/Problem.R")
source("ReJudge/Page/Report.R")
source("ReJudge/Dom/Xml2.R")
source("ReJudge/App/App.R")
source("ReJudge/App/Delegate.R")
source("ReJudge/App/Effect.R")
source("ReJudge/Domain/Submission/Title.R")
source("ReJudge/Domain/Problem/Id.R")
source("ReJudge/Domain/Run/Last.R")
source("ReJudge/Domain/Report/Table.R")
source("ReJudge/Domain/Report/Title.R")
source("ReJudge/Domain/Report/Details.R")
source("ReJudge/Domain/Report/Entire.R")

app.lastreport <- app.delegate(function() {
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
    entire <- report.entire(engine.xml2)
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
      "the report was not received",
      text.bind(
        page,
        function(page) {
          text.default(
            fallback = text.default(
              fallback = "unexpected report structure",
              origin = text.nonempty(entire(page))
            ),
            origin = text.nonempty(
              text.fstring(
                "%s%s%s",
                text.paragraph(title(page)),
                text.paragraph(table(page)),
                text.paragraph(details(page))
              )
            )
          )
        }
      )
    )
  })
  app.effect(
    console.message(report)
  )
})
