source("ReJudge/Text/Text.R")
source("ReJudge/Installation/Installation.R")
source("ReJudge/Installation/Lambda.R")

installation.verbose <- function(msg, origin) {
  installation.lambda(
    function() {
      c(
        code(origin),
        deparse(
          bquote(
            message(.(contents(msg)))
          )
        )
      )
    }
  )
}
