source("ReJudge/Installation/Installation.R")
source("ReJudge/Installation/Lambda.R")

installation.withoptions <- function(origin) {
  installation.lambda(
    function() {
      c(
        deparse(
          quote({
            old <- options(
              pkgType = "binary",
              install.packages.compile.from.source = "never"
            )
            on.exit(options(old), add = TRUE)
          })
        ),
        code(origin)
      )
    }
  )
}
