source("ReJudge/Token/Token.R")

token.plain <- function(value, expiration) {
  structure(
    list(
      value = value,
      expiration = expiration
    ),
    class = "token_plain"
  )
}

value.token_plain <- function(x) contents(x$value)
expiration.token_plain <- function(x) contents(x$expiration)
