source("ReJudge/Installation/Installation.R")
source("ReJudge/Installation/Lambda.R")

installation.consistent <- function(origin) {
  installation.lambda(
    function() {
      c(
        code(origin),
        deparse(
          quote({
            path <- normalizePath(
              file.path(getwd(), "RePackage"),
              winslash = "/",
              mustWork = TRUE
            )
            exports <- sub(
              "^export\\((.*)\\)$",
              "\\1",
              grep("^export\\(", readLines(file.path(path, "NAMESPACE")), value = TRUE)
            )
            env <- new.env(parent = globalenv())
            for (f in list.files(file.path(path, "R"), full.names = TRUE)) {
              sys.source(f, envir = env)
            }
            missing <- setdiff(exports, ls(env))
            if (length(missing) > 0) {
              stop("Functions exported in NAMESPACE but missing in R/: ",
                   paste(missing, collapse = ", "))
            }
          })
        )
      )
    }
  )
}
