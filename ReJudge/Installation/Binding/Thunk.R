source("ReJudge/Installation/Binding/Binding.R")
source("ReJudge/Text/Text.R")
source("ReJudge/Text/Pretty.R")
source("ReJudge/Text/Interpolated.R")

binding.thunk <- function(x) {
  structure(
    list(
      origin = x
    ),
    class = "binding_thunk"
  )
}

name.binding_thunk <- function(x) name(x$origin)

val.binding_thunk <- function(x) {
  contents(
    text.pretty(
      text.interpolated(
        paste(
          deparse(
            quote(
              local({
                cache <- new.env(parent = emptyenv())
                function() {
                  if (!exists("val", envir = cache, inherits = FALSE)) {
                    cache$val <- `@@`(origin)
                  }
                  cache$val
                }
              })
            )
          ),
          collapse = "\n"
        ),
        origin = val(x$origin)
      )
    )
  )
}

ref.binding_thunk <- function(x) paste0(name(x$origin), "()")
