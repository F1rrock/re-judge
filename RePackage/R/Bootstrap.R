rejudge.project <- function() {
  project <- rstudioapi::getActiveProject()
  if (is.null(project) || identical(project, "")) stop("RStudio project is not open")
  project
}

rejudge.manifest <- function() {
  file.path(rejudge.project(), "ReJudge/Manifest.R")
}

rejudge.load <- function() {
  old <- getwd()
  on.exit(setwd(old), add = TRUE)
  setwd(rejudge.project())
  source(rejudge.manifest(), local = .GlobalEnv)
}
