source("Src/Dom/Engine/Engine.R")

engine.fake = function(d) {
  structure(
    list(
      dom = dom,
    ),
    class = "fake_engine"
  )
}

dom.fake_engine  <- function(x) x$dom
