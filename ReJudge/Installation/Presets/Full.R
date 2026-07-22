source("ReJudge/Installation/WithReport.R")
source("ReJudge/Installation/Verbose.R")
source("ReJudge/Installation/Credentials/Authorized.R")
source("ReJudge/Installation/RStudio.R")
source("ReJudge/Installation/Available.R")
source("ReJudge/Installation/Package.R")
source("ReJudge/Installation/Consistent.R")
source("ReJudge/Installation/WellFormed.R")
source("ReJudge/Installation/WithGlobal.R")
source("ReJudge/Installation/Credentials/Login.R")
source("ReJudge/Installation/Credentials/Pass.R")
source("ReJudge/Installation/Credentials/Contest.R")
source("ReJudge/Installation/Env.R")
source("ReJudge/Installation/Cleanup.R")
source("ReJudge/Installation/WithDeps.R")
source("ReJudge/Installation/WithOptions.R")
source("ReJudge/Installation/From.R")
source("ReJudge/Text/Code.R")

installation.full <- function(src, server, client) {
  installation.withreport(
    installation.verbose(
      "ReJudge installed.",
      installation.verbose(
        ".env created.",
        installation.withglobal(
          binding.of(
            "contest",
            text.code(installation.contest)
          ),
          function(contest) {
            installation.withglobal(
              binding.of(
                "pass",
                text.code(installation.pass)
              ),
              function(pass) {
                installation.withglobal(
                  binding.of(
                    "login",
                    text.code(installation.login)
                  ),
                  function(login) {
                    installation.authorized(
                      login, pass, contest,
                      server, client,
                      installation.env(
                        login, pass, contest,
                        server, client,
                        installation.rstudio(
                          installation.available(
                            installation.package(
                              installation.wellformed(
                                installation.withoptions(
                                  installation.withdeps(
                                    installation.cleanup(
                                      installation.from(src)
                                    )
                                  )
                                )
                              )
                            )
                          )
                        )
                      )
                    )
                  }
                )
              }
            )
          }
        )
      )
    )
  )
}
