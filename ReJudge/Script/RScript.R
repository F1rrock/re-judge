source("ReJudge/Script/Script.R")
source("ReJudge/Text/Text.R")
source("ReJudge/Script/Context/Context.R")

script.r <- function(path, input, ctx) {
  structure(list(path = path, input = input, context = ctx), class = "script_r")
}

result.script_r <- function(x) {
  path  <- contents(x$path)
  input <- contents(x$input)
  stdin <- tempfile(fileext = ".txt")
  writeLines(input, stdin)
  on.exit(unlink(stdin), add = TRUE)
  tmp <- tempfile(fileext = ".R")
  ctx <- core(x$context)
  origin <- readLines(path, warn = FALSE)
  writeLines(c(ctx, origin), tmp)
  on.exit(unlink(tmp), add = TRUE)
  result <- system2(
    "Rscript",
    args = c("--vanilla", tmp),
    stdin = stdin,
    stdout = TRUE,
    stderr = FALSE
  )
  paste(result, collapse = "\n")
}
