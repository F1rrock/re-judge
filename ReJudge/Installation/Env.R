source("ReJudge/Text/Text.R")
source("ReJudge/Text/Interpolated.R")
source("ReJudge/Text/Pretty.R")
source("ReJudge/Installation/Installation.R")
source("ReJudge/Installation/Lambda.R")

installation.env <- function(login, pass, contest, url, client, origin) {
  installation.lambda(
    function() {
      paste(
        code(origin),
        contents(
          text.pretty(
            text.interpolated(
              paste(
                deparse(
                  bquote({
                    source("ReJudge/Text/Text.R")
                    escaped <- function(x) {
                      x <- as.character(x)
                      x <- gsub("\\\\", "\\\\\\\\", x)
                      x <- gsub("\"", "\\\\\"", x)
                      paste0("\"", x, "\"")
                    }
                    envpath <- file.path(getwd(), ".env")
                    writeLines(
                      c(
                        paste0("LOGIN=", escaped(contents(`@@`(login)))),
                        paste0("PASSWORD=", escaped(contents(`@@`(pass)))),
                        paste0("CONTEST_ID=", escaped(contents(`@@`(contest)))),
                        paste0("BASE_URL=", escaped(contents(`@@`(url)))),
                        paste0("CLIENT_PATH=", escaped(contents(`@@`(client))))
                      ),
                      envpath
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
