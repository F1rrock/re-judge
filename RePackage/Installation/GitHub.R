url <- "http://0.0.0.0:90"
client <- "ejudge"
contest <- "1"
login <- "vader"
pass <- "ejudge"

old_options <- options(
  pkgType = "binary",
  install.packages.compile.from.source = "never"
)

on.exit(options(old_options), add = TRUE)

deps <- c("dotenv", "httr", "xml2", "rvest", "jsonlite", "rstudioapi")

missing_deps <- deps[
  !vapply(deps, requireNamespace, logical(1), quietly = TRUE)
]

if (length(missing_deps) > 0) {
  install.packages(
    missing_deps,
    repos = "https://cran.rstudio.com",
    type = "binary"
  )
}

failed_deps <- deps[
  !vapply(deps, requireNamespace, logical(1), quietly = TRUE)
]

if (length(failed_deps) > 0) {
  stop(
    "Failed to install required dependencies: ",
    paste(failed_deps, collapse = ", ")
  )
}

if ("package:ReJudge" %in% search()) {
  detach("package:ReJudge", unload = TRUE)
}

if ("ReJudge" %in% loadedNamespaces()) {
  unloadNamespace("ReJudge")
}

old_pkg <- file.path(.libPaths()[1], "ReJudge")

if (dir.exists(old_pkg)) {
  unlink(old_pkg, recursive = TRUE, force = TRUE)
}

src <- "https://github.com/F1rrock/re-judge/archive/refs/heads/main.zip"

zip <- tempfile(fileext = ".zip")
download.file(src, zip, mode = "wb")

tmp <- file.path(tempdir(), "re-judge-setup")
unlink(tmp, recursive = TRUE, force = TRUE)
dir.create(tmp, showWarnings = FALSE, recursive = TRUE)

unzip(zip, exdir = tmp)

root <- list.dirs(tmp, recursive = FALSE, full.names = TRUE)[[1]]

files <- list.files(root, all.files = TRUE, no.. = TRUE, full.names = TRUE)
file.copy(from = files, to = ".", recursive = TRUE, overwrite = TRUE)

env_escape <- function(x) {
  x <- as.character(x)
  x <- gsub("\\\\", "\\\\\\\\", x)
  x <- gsub("\"", "\\\\\"", x)
  paste0("\"", x, "\"")
}

env_path <- file.path(getwd(), ".env")

writeLines(
  c(
    paste0("LOGIN=", env_escape(login)),
    paste0("PASSWORD=", env_escape(pass)),
    paste0("CONTEST_ID=", env_escape(contest)),
    paste0("BASE_URL=", env_escape(url)),
    paste0("CLIENT_PATH=", env_escape(client))
  ),
  env_path
)

pkg_path <- normalizePath(
  file.path(getwd(), "RePackage"),
  winslash = "/",
  mustWork = TRUE
)

read.dcf(file.path(pkg_path, "DESCRIPTION"))
read.dcf(file.path(pkg_path, "inst", "rstudio", "addins.dcf"), all = TRUE)

exports <- sub(
  "^export\\((.*)\\)$",
  "\\1",
  grep(
    "^export\\(",
    readLines(file.path(pkg_path, "NAMESPACE")),
    value = TRUE
  )
)

env <- new.env(parent = globalenv())

for (f in list.files(file.path(pkg_path, "R"), full.names = TRUE)) {
  sys.source(f, envir = env)
}

missing_exports <- setdiff(exports, ls(env))

if (length(missing_exports) > 0) {
  stop(
    "Functions exported in NAMESPACE but missing in R/: ",
    paste(missing_exports, collapse = ", ")
  )
}

out <- tempfile(fileext = ".txt")
err <- tempfile(fileext = ".txt")

system2(
  "R",
  args = c(
    "CMD", "INSTALL",
    "--no-clean-on-error",
    "--no-staged-install",
    pkg_path
  ),
  stdout = out,
  stderr = err
)

cat(readLines(out, warn = FALSE), sep = "\n")
cat(readLines(err, warn = FALSE), sep = "\n")

if (!dir.exists(old_pkg)) {
  stop("ReJudge directory was not created in the R library")
}

if (!requireNamespace("ReJudge", quietly = TRUE)) {
  stop("ReJudge directory exists, but namespace cannot be loaded")
}

rstudioapi::writeRStudioPreference("show_hidden_files", TRUE)

if (rstudioapi::isAvailable()) {
  rstudioapi::filesPaneNavigate(normalizePath(getwd(), winslash = "/", mustWork = TRUE))
}

message(".env created.")
message("ReJudge installed.")