source("ReJudge/Installation/Installation.R")
source("ReJudge/Installation/Lambda.R")

installation.cleanup <- function(origin) {
  installation.lambda(
    function() {
      c(
        deparse(
          quote({
            if ("package:ReJudge" %in% search()) {
              detach("package:ReJudge", unload = TRUE)
            }
            if ("ReJudge" %in% loadedNamespaces()) {
              unloadNamespace("ReJudge")
            }
            pkg <- file.path(.libPaths()[1], "ReJudge")
            if (dir.exists(pkg)) {
              unlink(pkg, recursive = TRUE, force = TRUE)
            }
          })
        ),
        code(origin)
      )
    }
  )
}
