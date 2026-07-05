source("ReJudge/Text/Text.R")
source("ReJudge/Installation/Installation.R")
source("ReJudge/Installation/Lambda.R")

installation.env <- function(login, pass, contest, url, client, origin) {
  installation.lambda(
    function() {
      c(
        code(origin),
        deparse(
          bquote({
            escaped <- function(x) {
              x <- as.character(x)
              x <- gsub("\\\\", "\\\\\\\\", x)
              x <- gsub("\"", "\\\\\"", x)
              paste0("\"", x, "\"")
            }
            envpath <- file.path(getwd(), ".env")
            writeLines(
              c(
                paste0("LOGIN=", escaped(.(login))),
                paste0("PASSWORD=", escaped(.(pass))),
                paste0("CONTEST_ID=", escaped(.(contest))),
                paste0("BASE_URL=", escaped(.(url))),
                paste0("CLIENT_PATH=", escaped(.(client)))
              ),
              envpath
            )
          })
        )
      )
    }
  )
}
