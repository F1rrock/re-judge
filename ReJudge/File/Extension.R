source("ReJudge/Text/Regex.R")
source("ReJudge/File/Name.R")

file.extension <- function(file) {
  text.regex(
    "\\.([^.]+)$",
    file.name(file)
  )
}
