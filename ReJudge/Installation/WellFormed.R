source("ReJudge/Installation/Installation.R")
source("ReJudge/Installation/Lambda.R")

installation.wellformed <- function(origin) {
  installation.lambda(
    function() {
      paste(
        code(origin),
        paste(
          deparse(
            quote({
              path <- normalizePath(
                file.path(getwd(), "RePackage"),
                winslash = "/",
                mustWork = TRUE
              )
              read.dcf(file.path(path, "DESCRIPTION"))
              read.dcf(file.path(path, "inst", "rstudio", "addins.dcf"), all = TRUE)
            })
          ),
          collapse = "\n"
        ),
        sep = "\n"
      )
    }
  )
}
