source("ReJudge/Text/Join.R")
source("ReJudge/Text/Then.R")
source("ReJudge/Text/Asserted.R")
source("ReJudge/Text/Result.R")
source("ReJudge/Text/Palette.R")
source("ReJudge/Workspace/Env/Presets/Variable.R")
source("ReJudge/Resource/Url.R")
source("ReJudge/Collection/Map.R")
source("ReJudge/File/Name.R")
source("ReJudge/File/RFile.R")
source("ReJudge/File/Url.R")
source("ReJudge/File/Required.R")
source("ReJudge/Spec/Spec.R")
source("ReJudge/Script/RScript.R")
source("ReJudge/Script/WithResources.R")
source("ReJudge/Script/Context/Presets/OfStdIn.R")
source("ReJudge/Page/Main.R")
source("ReJudge/Page/Problem.R")
source("ReJudge/Session/Ejudge.R")
source("ReJudge/Session/Presets/Ready.R")
source("ReJudge/Dom/Xml2.R")
source("ReJudge/Http/Httr/Driver.R")
source("ReJudge/Workspace/RStudio/Current.R")
source("ReJudge/Workspace/Console/Presets/Message.R")
source("ReJudge/App/Delegate.R")
source("ReJudge/App/Effect.R")
source("ReJudge/Domain/Problem/Id.R")
source("ReJudge/Domain/Problem/Description.R")
source("ReJudge/Domain/Problem/Examples.R")
source("ReJudge/Domain/Problem/Attachments.R")
source("ReJudge/Domain/Submission/File.R")
source("ReJudge/Domain/Submission/Title.R")

app.testification <- app.delegate(
  function() {
    address <- env.variable("BASE_URL")
    client <- env.variable("CLIENT_PATH")
    session <- local({
      auth <- session.ejudge(
        driver = httr.driver,
        address,
        client
      )
      session.ready(
        auth(
          login   = env.variable("LOGIN"),
          pass    = env.variable("PASSWORD"),
          contest = env.variable("CONTEST_ID")
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
      page <- page.problem(
        driver = httr.driver,
        address,
        client
      )
      page(
        session,
        id(
          main(session),
          submission.title(submission)
        )
      )
    })
    examples <- local({
      description <- problem.description(engine.xml2)
      problem.examples(
        description(problem)
      )
    })
    attachments <- problem.attachments(engine.xml2)
    verdict <- text.then(
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
      text.green("Sample tests passed!")
    )
    app.effect(
      console.message(verdict)
    )
  }
)
