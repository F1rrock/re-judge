source("Src/Text/Text.R")
source("Src/Text/First.R")
source("Src/Text/Join.R")
source("Src/Text/Bind.R")
source("Src/Text/Then.R")
source("Src/Text/Required.R")
source("Src/Text/Default.R")
source("Src/Text/Asserted.R")
source("Src/Text/Result.R")
source("Src/Text/Palette.R")
source("Src/Text/Presets/Variable.R")
source("Src/Number/Number.R")
source("Src/Number/Difference.R")
source("Src/Number/Str.R")
source("Src/Spec/Spec.R")
source("Src/Collection/Map.R")
source("Src/Collection/Drop.R")
source("Src/File/RFile.R")
source("Src/File/Required.R")
source("Src/Script/RScript.R")
source("Src/Page/Submit.R")
source("Src/Page/Status.R")
source("Src/Page/Main.R")
source("Src/Page/Report.R")
source("Src/Page/Problem.R")
source("Src/Session/Ejudge.R")
source("Src/Session/Presets/Ready.R")
source("Src/Json/JsonLite.R")
source("Src/Dom/Xml2.R")
source("Src/Http/Httr/Driver.R")
source("Src/Workspace/Rstudio/Current.R")
source("Src/App/Delegate.R")
source("Src/App/Console.R")
source("Src/Domain/Problem/Id.R")
source("Src/Domain/Problem/Description.R")
source("Src/Domain/Problem/Language.R")
source("Src/Domain/Problem/Languages.R")
source("Src/Domain/Problem/Examples.R")
source("Src/Domain/Submission/File.R")
source("Src/Domain/Submission/Title.R")
source("Src/Domain/Submission/Language.R")
source("Src/Domain/Run/Id.R")
source("Src/Domain/Run/Status.R")
source("Src/Domain/Report/Pooling.R")
source("Src/Domain/Report/Title.R")
source("Src/Domain/Report/Table.R")

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
    table <- report.table(engine.xml2)
    title <- report.title(engine.xml2)
    page <- local({
      page <- page.report(
        driver = httr.driver,
        address,
        client
      )
      page(session, run)
    })
    text.default(
      fallback = text.fstring(
        "Result: %s",
        text.required(
          "unexpected report structure",
          text.nonempty(
            title(page)
          )
        )
      ),
      origin = text.nonempty(
        text.bind(
          run,
          function(run) {
            report.pooling(
              status,
              downtime = 1,
              table(page)
            )
          }
        )
      )
    )
  })
  app.console(report)
})
