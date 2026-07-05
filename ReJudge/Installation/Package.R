source("ReJudge/Installation/Installation.R")
source("ReJudge/Installation/Lambda.R")

installation.package <- function(origin) {
  installation.lambda(
    function() {
      c(
        code(origin),
        deparse(
          quote({
            out <- tempfile(fileext = ".txt")
            err <- tempfile(fileext = ".txt")
            path <- normalizePath(
              file.path(getwd(), "RePackage"),
              winslash = "/",
              mustWork = TRUE
            )
            system2(
              "R",
              args = c("CMD", "INSTALL", "--no-clean-on-error", "--no-staged-install", path),
              stdout = out,
              stderr = err
            )
            cat(readLines(out, warn = FALSE), sep = "\n")
            cat(readLines(err, warn = FALSE), sep = "\n")
          })
        )
      )
    }
  )
}
