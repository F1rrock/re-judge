source("ReJudge/Text/Text.R")
source("ReJudge/Installation/Installation.R")
source("ReJudge/Installation/Lambda.R")

installation.verbose <- function(msg, origin) {
  installation.lambda(
    function() {
      paste(
        code(origin),
        paste(
          deparse(
            bquote(
              message(.(contents(msg)))
            )
          ),
          collapse = "\n"
        ),
        sep = "\n"
      )
    }
  )
}
