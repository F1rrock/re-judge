source("Src/Text/Text.R")
source("Src/Text/Fstring.R")
source("Src/Text/Required.R")
source("Src/Text/Env.R")
source("Src/Text/Logged.R")

text.variable <- function(name) {
  text.logged(
    text.fstring('fetching %s...', name),
    text.required(
      text.fstring('environment variable %s is not defined', name),
      text.env(name)
    )
  )
}
