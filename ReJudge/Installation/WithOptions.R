source("ReJudge/Installation/Installation.R")
source("ReJudge/Installation/Lambda.R")

installation.withoptions <- function(origin) {
  installation.lambda(
    function() {
      paste(
        paste(
          deparse(
            quote({
              old <- options(
                pkgType = "binary",
                install.packages.compile.from.source = "never"
              )
              on.exit(options(old), add = TRUE)
            })
          ),
          collapse = "\n"
        ),
        code(origin),
        sep = "\n"
      )
    }
  )
}
