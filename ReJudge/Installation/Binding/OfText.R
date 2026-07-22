source("ReJudge/Installation/Binding/Binding.R")
source("ReJudge/Text/Text.R")

binding.oftext <- function(n, v) {
  structure(
    list(
      name = n,
      val = v
    ),
    class = "binding_oftext"
  )
}

val.binding_oftext <- function(x) contents(x$val)
name.binding_oftext <- function(x) contents(x$name)
ref.binding_oftext <- function(x) contents(x$name)
