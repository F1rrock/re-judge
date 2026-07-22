contest <- local({
  cache <- new.env(parent = emptyenv())
  function() {
    if (!exists("val", envir = cache, inherits = FALSE)) {
      cache$val <- {
        source("ReJudge/Workspace/RStudio/Prompt.R")
        source("ReJudge/Text/NonEmpty.R")
        source("ReJudge/Text/Required.R")
        source("ReJudge/Text/Text.R")
        contents(text.required("contest id is required", text.nonempty(rstudio.prompt(
          title = "Contest ID",
          message = "Enter contest ID:", default = "1"
        ))))
      }
    }
    cache$val
  }
})
pass <- local({
  cache <- new.env(parent = emptyenv())
  function() {
    if (!exists("val", envir = cache, inherits = FALSE)) {
      cache$val <- {
        source("ReJudge/Workspace/RStudio/PassPrompt.R")
        source("ReJudge/Text/NonEmpty.R")
        source("ReJudge/Text/Required.R")
        source("ReJudge/Text/Text.R")
        contents(text.required("password is required", text.nonempty(rstudio.passprompt(message = "Enter your ejudge password:"))))
      }
    }
    cache$val
  }
})
login <- local({
  cache <- new.env(parent = emptyenv())
  function() {
    if (!exists("val", envir = cache, inherits = FALSE)) {
      cache$val <- {
        source("ReJudge/Workspace/RStudio/Prompt.R")
        source("ReJudge/Text/NonEmpty.R")
        source("ReJudge/Text/Required.R")
        source("ReJudge/Text/Text.R")
        contents(text.required("login is required", text.nonempty(rstudio.prompt(
          title = "Ejudge Login",
          message = "Enter your ejudge login:", default = ""
        ))))
      }
    }
    cache$val
  }
})
{
    old <- options(pkgType = "binary", install.packages.compile.from.source = "never")
    on.exit(options(old), add = TRUE)
}
{
    required <- c("dotenv", "httr", "xml2", "rvest", "jsonlite", 
        "rstudioapi")
    missing <- required[!vapply(required, requireNamespace, logical(1), 
        quietly = TRUE)]
    if (length(missing) > 0) {
        install.packages(missing, repos = "https://cran.rstudio.com", 
            type = "binary")
    }
    failed <- required[!vapply(required, requireNamespace, logical(1), 
        quietly = TRUE)]
    if (length(failed) > 0) {
        stop("Failed to install required dependencies: ", paste(failed, 
            collapse = ", "))
    }
}
{
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
}
{
  src <- "http://0.0.0.0:8000/re-judge-main.zip"
  zip <- tempfile(fileext = ".zip")
  download.file(src, zip, mode = "wb")
  tmp <- file.path(tempdir(), "re-judge-setup")
  unlink(tmp, recursive = TRUE, force = TRUE)
  dir.create(tmp, showWarnings = FALSE, recursive = TRUE)
  unzip(zip, exdir = tmp)
  root <- list.dirs(tmp, recursive = FALSE, full.names = TRUE)[[1]]
  files <- list.files(root,
    all.files = TRUE, no.. = TRUE,
    full.names = TRUE
  )
  file.copy(from = files, to = ".", recursive = TRUE, overwrite = TRUE)
}
{
    path <- normalizePath(file.path(getwd(), "RePackage"), winslash = "/", 
        mustWork = TRUE)
    read.dcf(file.path(path, "DESCRIPTION"))
    read.dcf(file.path(path, "inst", "rstudio", "addins.dcf"), 
        all = TRUE)
}
{
    out <- tempfile(fileext = ".txt")
    err <- tempfile(fileext = ".txt")
    path <- normalizePath(file.path(getwd(), "RePackage"), winslash = "/", 
        mustWork = TRUE)
    system2("R", args = c("CMD", "INSTALL", "--no-clean-on-error", 
        "--no-staged-install", path), stdout = out, stderr = err)
    cat(readLines(out, warn = FALSE), sep = "\n")
    cat(readLines(err, warn = FALSE), sep = "\n")
}
{
    pkg <- file.path(.libPaths()[1], "ReJudge")
    if (!dir.exists(pkg)) {
        stop("ReJudge directory was not created in the R library")
    }
    if (!requireNamespace("ReJudge", quietly = TRUE)) {
        stop("ReJudge directory exists, but namespace cannot be loaded")
    }
}
{
  source("ReJudge/Text/Text.R")
  escaped <- function(x) {
    x <- as.character(x)
    x <- gsub("\\\\", "\\\\\\\\", x)
    x <- gsub("\"", "\\\\\"", x)
    paste0("\"", x, "\"")
  }
  envpath <- file.path(getwd(), ".env")
  writeLines(c(
    paste0("LOGIN=", escaped(contents(login()))),
    paste0("PASSWORD=", escaped(contents(pass()))), paste0(
      "CONTEST_ID=",
      escaped(contents(contest()))
    ), paste0(
      "BASE_URL=",
      escaped(contents("0.0.0.0:90"))
    ), paste0(
      "CLIENT_PATH=",
      escaped(contents("ejudge"))
    )
  ), envpath)
}
{
  source("ReJudge/Session/Ejudge.R")
  source("ReJudge/Http/Httr/Driver.R")
  source("ReJudge/Text/Required.R")
  source("ReJudge/Text/Text.R")
  source("ReJudge/Text/Then.R")
  source("ReJudge/Text/Token.R")
  source("ReJudge/Text/NonEmpty.R")
  source("ReJudge/Domain/Token/Ejsid.R")
  source("ReJudge/Domain/Token/Sid.R")
  auth <- session.ejudge(
    httr.driver, contents("0.0.0.0:90"),
    contents("ejudge")
  )
  session <- auth(
    contents(login()), contents(pass()),
    contents(contest())
  )
  contents(text.required("authorization failed", text.then(
    text.nonempty(text.token(token.ejsid(session))),
    text.nonempty(text.token(token.sid(session)))
  )))
}
{
    rstudioapi::writeRStudioPreference("show_hidden_files", TRUE)
    if (rstudioapi::isAvailable()) {
        rstudioapi::navigateToFile(file.path(getwd(), "Src/Example.R"))
        rstudioapi::filesPaneNavigate(normalizePath(getwd(), 
            winslash = "/", mustWork = TRUE))
    }
}
message(".env created.")
message("ReJudge installed.")
