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
    src <- "http://10.21.17.68/files/re-judge/re-judge-main.zip"
    zip <- tempfile(fileext = ".zip")
    download.file(src, zip, mode = "wb")
    tmp <- file.path(tempdir(), "re-judge-setup")
    unlink(tmp, recursive = TRUE, force = TRUE)
    dir.create(tmp, showWarnings = FALSE, recursive = TRUE)
    unzip(zip, exdir = tmp)
    root <- list.dirs(tmp, recursive = FALSE, full.names = TRUE)[[1]]
    files <- list.files(root, all.files = TRUE, no.. = TRUE, 
        full.names = TRUE)
    file.copy(from = files, to = ".", recursive = TRUE, overwrite = TRUE)
}
{
    escaped <- function(x) {
        x <- as.character(x)
        x <- gsub("\\\\", "\\\\\\\\", x)
        x <- gsub("\"", "\\\\\"", x)
        paste0("\"", x, "\"")
    }
    envpath <- file.path(getwd(), ".env")
    writeLines(c(paste0("LOGIN=", escaped(rstudioapi::showPrompt(title = "Ejudge Login", 
        message = "Enter your ejudge login:", default = ""))), 
        paste0("PASSWORD=", escaped(rstudioapi::askForPassword(prompt = "Enter your ejudge password:"))), 
        paste0("CONTEST_ID=", escaped(rstudioapi::showPrompt(title = "Contest ID", 
            message = "Enter contest ID:", default = "1"))), 
        paste0("BASE_URL=", escaped("10.21.17.68")), paste0("CLIENT_PATH=", 
            escaped("new-client"))), envpath)
}
{
    path <- normalizePath(file.path(getwd(), "RePackage"), winslash = "/", 
        mustWork = TRUE)
    read.dcf(file.path(path, "DESCRIPTION"))
    read.dcf(file.path(path, "inst", "rstudio", "addins.dcf"), 
        all = TRUE)
}
{
    path <- normalizePath(file.path(getwd(), "RePackage"), winslash = "/", 
        mustWork = TRUE)
    exports <- sub("^export\\((.*)\\)$", "\\1", grep("^export\\(", 
        readLines(file.path(path, "NAMESPACE")), value = TRUE))
    env <- new.env(parent = globalenv())
    for (f in list.files(file.path(path, "R"), full.names = TRUE)) {
        sys.source(f, envir = env)
    }
    missing <- setdiff(exports, ls(env))
    if (length(missing) > 0) {
        stop("Functions exported in NAMESPACE but missing in R/: ", 
            paste(missing, collapse = ", "))
    }
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
    rstudioapi::writeRStudioPreference("show_hidden_files", TRUE)
    if (rstudioapi::isAvailable()) {
        rstudioapi::navigateToFile(file.path(getwd(), "Src/Example.R"))
        rstudioapi::filesPaneNavigate(normalizePath(getwd(), 
            winslash = "/", mustWork = TRUE))
    }
}
message(".env created.")
message("ReJudge installed.")
