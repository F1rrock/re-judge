source("Src/Text/Regex.R")
source("Src/File/Name.R")

file.extension <- function(file) {
  text.regex(
    "\\.([^.]+)$",
    file.name(file)
  )
}
