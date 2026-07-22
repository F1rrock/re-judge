source("ReJudge/Text/Text.R")
source("ReJudge/Text/Interpolated.R")
source("ReJudge/Text/Pretty.R")
source("ReJudge/Installation/Lambda.R")

installation.authorized <- function(login, pass, contest, url, client, origin) {
  installation.lambda(
    function() {
      paste(
        code(origin),
        contents(
          text.pretty(
            text.interpolated(
              paste(
                deparse(
                  quote({
                    source("ReJudge/Session/Ejudge.R")
                    source("ReJudge/Http/Httr/Driver.R")
                    source("ReJudge/Text/Required.R")
                    source("ReJudge/Text/Text.R")
                    source("ReJudge/Text/Then.R")
                    source("ReJudge/Text/Token.R")
                    source("ReJudge/Text/NonEmpty.R")
                    source("ReJudge/Domain/Token/Ejsid.R")
                    source("ReJudge/Domain/Token/Sid.R")
                    auth <- session.ejudge(
                      httr.driver, 
                      contents(`@@`(url)), 
                      contents(`@@`(client))
                    )
                    session <- auth(
                      contents(`@@`(login)),
                      contents(`@@`(pass)), 
                      contents(`@@`(contest))
                    )
                    contents(
                      text.required(
                        "authorization failed",
                        text.then(
                          text.nonempty(
                            text.token(
                              token.ejsid(session)
                            )
                          ),
                          text.nonempty(
                            text.token(
                              token.sid(session)
                            )
                          )
                        )
                      )
                    )
                  })
                ),
                collapse = "\n"
              ),
              login = login, 
              pass = pass, 
              contest = contest, 
              url = url, 
              client = client
            )
          )
        ),
        sep = "\n"
      )
    }
  )
}
