rejudge.project.file <- function(path) {
  existing <- list.files(
    path,
    pattern = "\\.Rproj$",
    full.names = TRUE
  )
  if (length(existing) > 0) {
    return(normalizePath(existing[[1]], winslash = "/", mustWork = TRUE))
  }
  name <- paste0(
    basename(normalizePath(path, winslash = "/", mustWork = TRUE)),
    ".Rproj"
  )
  file <- file.path(path, name)
  writeLines(
    c(
      "Version: 1.0",
      "",
      "RestoreWorkspace: Default",
      "SaveWorkspace: Default",
      "AlwaysSaveHistory: Default",
      "",
      "EnableCodeIndexing: Yes",
      "UseSpacesForTab: Yes",
      "NumSpacesForTab: 2",
      "Encoding: UTF-8",
      "",
      "RnwWeave: Sweave",
      "LaTeX: pdfLaTeX"
    ),
    file
  )
  normalizePath(file, winslash = "/", mustWork = TRUE)
}

rejudge.project <- function() {
  project <- rstudioapi::getActiveProject()
  if (!is.null(project) && !identical(project, "")) {
    return(normalizePath(project, winslash = "/", mustWork = TRUE))
  }
  path <- normalizePath(getwd(), winslash = "/", mustWork = TRUE)
  rejudge.project.file(path)
  path
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