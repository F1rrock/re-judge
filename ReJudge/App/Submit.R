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
source("ReJudge/Text/Presets/Paragraph.R")
source("ReJudge/Number/Number.R")
source("ReJudge/Number/Difference.R")
source("ReJudge/Number/Str.R")
source("ReJudge/Collection/Map.R")
source("ReJudge/Collection/Drop.R")
source("ReJudge/Resource/Url.R")
source("ReJudge/File/RFile.R")
source("ReJudge/File/Url.R")
source("ReJudge/File/Name.R")
source("ReJudge/File/Required.R")
source("ReJudge/Spec/Spec.R")
source("ReJudge/Script/RScript.R")
source("ReJudge/Script/WithResources.R")
source("ReJudge/Script/Context/Presets/OfStdIn.R")
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
source("ReJudge/Workspace/RStudio/Current.R")
source("ReJudge/App/Delegate.R")
source("ReJudge/App/Console.R")
source("ReJudge/Domain/Problem/Id.R")
source("ReJudge/Domain/Problem/Description.R")
source("ReJudge/Domain/Problem/Attachments.R")
source("ReJudge/Domain/Problem/Language.R")
source("ReJudge/Domain/Problem/Languages.R")
source("ReJudge/Domain/Problem/Examples.R")
source("ReJudge/Domain/Submission/File.R")
source("ReJudge/Domain/Submission/Title.R")
source("ReJudge/Domain/Submission/Language.R")
source("ReJudge/Domain/Run/Id.R")
source("ReJudge/Domain/Run/Status.R")
source("ReJudge/Domain/Report/Pooling.R")
source("ReJudge/Domain/Report/Title.R")
source("ReJudge/Domain/Report/Table.R")
source("ReJudge/Domain/Report/Details.R")
source("ReJudge/Domain/Report/Entire.R")

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
  id <- local({
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
  problem <- local({
    page <- page.problem(
      driver = httr.driver,
      address,
      client
    )
    page(session, id)
  })
  examples <- local({
    description <- problem.description(engine.xml2)
    problem.examples(
      description(
        problem
      )
    )
  })
  language <- local({
    language <- problem.language(engine.xml2)
    languages <- problem.languages(engine.xml2)
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
            languages(problem)
          )
        )
      ),
      origin = text.nonempty(
        language(problem)
      )
    )
  })
  run <- local({
    run <- run.id(engine.xml2)
    attachments <- problem.attachments(engine.xml2)
    submit <- page.submit(
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
                script.withresources(
                  script.r(
                    submission.file(submission),
                    input(example),
                    context.ofstdin
                  ),
                  collection.map(
                    function(x) {
                      resource.url(
                        x, 
                        file.name(
                          file.url(x)
                        )
                      )
                    },
                    attachments(problem)
                  )
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
          run(
            submit(
              session,
              lang = language,
              id,
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
    details <- report.details(engine.xml2)
    entire <- report.entire(engine.xml2)
    text.bind(
      run,
      function(run) {
        page <- page.report(
          driver = httr.driver,
          address,
          client
        )
        text.required(
          "unexpected report structure",
          text.nonempty(
            report.pooling(
              status,
              downtime = 1,
              text.bind(
                page(session, run),
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
          )
        )
      }
    )
  })
  app.console(report)
})
