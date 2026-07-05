source("ReJudge/Installation/Installation.R")
source("ReJudge/Installation/Lambda.R")

installation.available <- function(origin) {
  installation.lambda(
    function() {
      c(
        code(origin),
        deparse(
          quote({
            pkg <- file.path(.libPaths()[1], "ReJudge")
            if (!dir.exists(pkg)) {
              stop("ReJudge directory was not created in the R library")
            }
            if (!requireNamespace("ReJudge", quietly = TRUE)) {
              stop("ReJudge directory exists, but namespace cannot be loaded")
            }
          })
        )
      )
    }
  )
}
