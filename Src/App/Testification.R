source("Src/Text/Join.R")
source("Src/Text/Then.R")
source("Src/Text/Asserted.R")
source("Src/Text/Result.R")
source("Src/Text/Palette.R")
source("Src/Text/Presets/Variable.R")
source("Src/Spec/Spec.R")
source("Src/Collection/Map.R")
source("Src/File/RFile.R")
source("Src/File/Required.R")
source("Src/Script/RScript.R")
source("Src/Page/Main.R")
source("Src/Page/Problem.R")
source("Src/Session/Ejudge.R")
source("Src/Session/Presets/Ready.R")
source("Src/Dom/Xml2.R")
source("Src/Http/Httr/Driver.R")
source("Src/Workspace/Rstudio/Current.R")
source("Src/App/Delegate.R")
source("Src/App/Console.R")
source("Src/Domain/Problem/Id.R")
source("Src/Domain/Problem/Description.R")
source("Src/Domain/Problem/Examples.R")
source("Src/Domain/Submission/File.R")
source("Src/Domain/Submission/Title.R")

app.testification <- app.delegate(
  function() {
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
    verdict <- text.then(
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
      text.green("Sample tests passed!")
    )
    app.console(verdict)
  }
)
