source("ReJudge/Installation/Installation.R")
source("ReJudge/Installation/Lambda.R")
source("ReJudge/Text/Text.R")

installation.withglobal <- function(binding, f) {
  installation.lambda(
    function() {
      paste(
        paste0(name(binding), " <- ", val(binding)),
        code(
          f(
            ref(binding)
          )
        ),
        sep = "\n"
      )
    }
  )
}
