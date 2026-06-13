source("ReJudge/Script/Script.R")
source("ReJudge/Text/Text.R")

script.r <- function(path, input) {
  structure(list(path = path, input = input), class = "script_r")
}

result.script_r <- function(x) {
  path  <- contents(x$path)
  input <- contents(x$input)
  rejudge   <- readLines(path, warn = FALSE)
  if (!any(grepl('file\\s*=\\s*"stdin"', rejudge))) {
    tmp <- tempfile(fileext = ".R")
    on.exit(unlink(tmp))
    writeLines(
      c('scan <- function(...) base::scan(file = "stdin", ...)', rejudge),
      tmp
    )
    path <- tmp
  }
  paste(
    system2("Rscript", args = path, input = input, stdout = TRUE),
    collapse = "\n"
  )
}
