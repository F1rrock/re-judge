source("ReJudge/Installation/Installation.R")
source("ReJudge/Installation/Lambda.R")

installation.rstudio <- function(origin) {
  installation.lambda(
    function() {
      c(
        code(origin),
        deparse(
          quote({
            rstudioapi::writeRStudioPreference("show_hidden_files", TRUE)
            if (rstudioapi::isAvailable()) {
              rstudioapi::navigateToFile(file.path(getwd(), "Src/Example.R"))
              rstudioapi::filesPaneNavigate(normalizePath(getwd(), winslash = "/", mustWork = TRUE))
            }
          })
        )
      )
    }
  )
}
