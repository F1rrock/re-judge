source("ReJudge/Effect/Lambda.R")
source("ReJudge/Text/Text.R")

env.assign <- function(name, value) {
  effect.lambda(
    function() {
      path <- file.path(getwd(), ".env")
      key  <- contents(name)
      val  <- contents(value)
      if (!file.exists(path)) stop(".env file does not exists")
      lines <- readLines(path, warn = FALSE, encoding = "UTF-8")
      pattern <- paste0("^", gsub("([.|()\\^{}+$*?]|\\[|\\])", "\\\\\\1", key), "=")
      idx <- grep(pattern, lines)
      entry <- paste0(key, "=", val)
      if (!length(idx)) stop(sprintf("no such variable \"%s\" in .env file", name))
      lines <- c(lines[-idx], entry)
      writeLines(lines, path, useBytes = TRUE)
    }
  )
}
