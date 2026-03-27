source("Text/Text.R")
source("Text/Fstring.R")
source("Text/Required.R")
source("Text/Env.R")
source("Text/Logged.R")

text.variable <- function(name) {
  text.logged(
    text.fstring('fetching %s...', name),
    text.required(
      text.fstring('environment variable %s is not defined', name),
      text.env(name)
    )
  )
}
