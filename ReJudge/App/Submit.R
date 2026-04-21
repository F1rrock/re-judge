source("ReJudge/Text/Text.R")
source("ReJudge/Text/First.R")
source("ReJudge/Text/Join.R")
source("ReJudge/Text/Bind.R")
source("ReJudge/Text/Then.R")
source("ReJudge/Text/Required.R")
source("ReJudge/Text/Default.R")
source("ReJudge/Text/Asserted.R")
source("ReJudge/Text/Result.R")
source("ReJudge/Text/Palette.R")
source("ReJudge/Text/Presets/Variable.R")
source("ReJudge/Number/Number.R")
source("ReJudge/Number/Difference.R")
source("ReJudge/Number/Str.R")
source("ReJudge/Spec/Spec.R")
source("ReJudge/Collection/Map.R")
source("ReJudge/Collection/Drop.R")
source("ReJudge/File/RFile.R")
source("ReJudge/File/Required.R")
source("ReJudge/Script/RScript.R")
source("ReJudge/Page/Submit.R")
source("ReJudge/Page/Status.R")
source("ReJudge/Page/Main.R")
source("ReJudge/Page/Report.R")
source("ReJudge/Page/Problem.R")
source("ReJudge/Session/Ejudge.R")
source("ReJudge/Session/Presets/Ready.R")
source("ReJudge/Json/JsonLite.R")
source("ReJudge/Dom/Xml2.R")
source("ReJudge/Http/Httr/Driver.R")
source("ReJudge/Workspace/Rstudio/Current.R")
source("ReJudge/App/Delegate.R")
source("ReJudge/App/Console.R")
source("ReJudge/Domain/Problem/Id.R")
source("ReJudge/Domain/Problem/Description.R")
source("ReJudge/Domain/Problem/Language.R")
source("ReJudge/Domain/Problem/Languages.R")
source("ReJudge/Domain/Problem/Examples.R")
source("ReJudge/Domain/Submission/File.R")
source("ReJudge/Domain/Submission/Title.R")
source("ReJudge/Domain/Submission/Language.R")
source("ReJudge/Domain/Run/Id.R")
source("ReJudge/Domain/Run/Status.R")
source("ReJudge/Domain/Solution/Pooling.R")
source("ReJudge/Domain/Solution/Report.R")

app.submit <- app.delegate(function() {
  address <- text.variable("BASE_URL")
  client <- text.variable("CLIENT_PATH")
  session <- local({
    auth <- session.ejudge(
      driver = httr.driver,
      address,
      client
    )
    session.ready(
      auth(
        login   = text.variable("LOGIN"),
        pass    = text.variable("PASSWORD"),
        contest = text.variable("CONTEST_ID")
      )
    )
  })
  submission <- file.required(
    "expected current file with .R extension",
    file.r(rstudio.current)
  )
  problem <- local({
    id <- problem.id(engine.xml2)
    main <- page.main(
      driver  = httr.driver, 
      address,
      client
    )
    id(
      main(session),
      submission.title(submission)
    )
  })
  examples <- local({
    description <- problem.description(engine.xml2)
    page <- page.problem(
      driver = httr.driver,
      address,
      client
    )
    problem.examples(
      description(
        page(
          session,
          problem
        )
      )
    )
  })
  language <- local({
    language <- problem.language(engine.xml2)
    languages <- problem.languages(engine.xml2)
    page <- local({
      page <- page.problem(
        driver = httr.driver,
        address,
        client
      )
      page(session, problem)
    })
    text.default(
      fallback = text.required(
        "can not identify problem's language",
        text.first(
          NA_character_,
          collection.drop(
            number.difference(
              submission.language(
                submission
              ),
              1
            ),
            languages(page)
          )
        )
      ),
      origin = text.nonempty(
        language(page)
      )
    )
  })
  run <- local({
    id <- run.id(engine.xml2)
    page <- page.submit(
      driver = httr.driver, 
      address,
      client
    )
    text.then(
      text.join(
        separator = "",
        collection.map(
          function(example) {
            text.asserted(
              text.result(
                script.r(
                  submission.file(submission),
                  input(example)
                )
              ),
              output(example),
              "sample test failed"
            )
          },
          examples
        )
      ),
      text.logged(
        text.green("sample tests passed"),
        text.required(
          "submission was not registered by ejudge",
          id(
            page(
              session,
              lang = language,
              problem,
              file = submission.file(submission)
            )
          )
        )
      )
    )
  })
  status <- local({
    status <- run.status(parser.jsonlite)
    page <- page.status(
      driver  = httr.driver, 
      address,
      client
    )
    status.logged(
      text.green("testing..."),
      status(
        page(
          session
        )
      )
    )
  })
  report <- local({
    report <- solution.report(engine.xml2)
    page <- page.report(
      driver = httr.driver,
      address,
      client
    )
    text.bind(
      run,
      function(run) {
        solution.pooling(
          status,
          downtime = 1,
          report(
            page(
              session,
              run
            )
          )
        )
      }
    )
  })
  app.console(
    text.required(
      "unexpected report structure",
      text.nonempty(
        report
      )
    )
  )
})
