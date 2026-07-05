source("ReJudge/Effect/Effect.R")

effect.lambda <- function(f) {
  structure(
    list(
      callback = f
    ),
    class = "effect_lambda"
  )
}

realize.effect_lambda <- function(x) x$callback()
