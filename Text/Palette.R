source("Text/Fstring.R")

text.red <- function(x) text.fstring("\033[31m%s\033[39m", x)

text.green <- function(x) text.fstring("\033[32m%s\033[39m", x)

text.yellow <- function(x) text.fstring("\033[33m%s\033[39m", x)
