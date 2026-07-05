source("ReJudge/Installation/Verbose.R")
source("ReJudge/Installation/RStudio.R")
source("ReJudge/Installation/Available.R")
source("ReJudge/Installation/Available.R")
source("ReJudge/Installation/Package.R")
source("ReJudge/Installation/Consistent.R")
source("ReJudge/Installation/WellFormed.R")
source("ReJudge/Installation/Bind.R")
source("ReJudge/Installation/Credentials/Login.R")
source("ReJudge/Installation/Credentials/Pass.R")
source("ReJudge/Installation/Credentials/Contest.R")
source("ReJudge/Installation/Env/MSU.R")
source("ReJudge/Installation/Cleanup.R")
source("ReJudge/Installation/WithDeps.R")
source("ReJudge/Installation/WithOptions.R")
source("ReJudge/Installation/From.R")

installation.full <- function(src) {
  installation.verbose(
    "ReJudge installed.",
    installation.verbose(
      ".env created.",
      installation.rstudio(
        installation.available(
          installation.package(
            installation.consistent(
              installation.wellformed(
                installation.bind(
                  installation.contest,
                  function(contest) {
                    installation.bind(
                      installation.pass,
                      function(pass) {
                        installation.bind(
                          installation.login,
                          function(login) {
                            installation.msu(
                              login, 
                              pass, 
                              contest,
                              installation.withoptions(
                                installation.withdeps(
                                  installation.cleanup(
                                    installation.from(src)
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
        )
      )
    )
  )
}
