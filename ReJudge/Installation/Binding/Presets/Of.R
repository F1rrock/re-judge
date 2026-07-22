source("ReJudge/Installation/Binding/OfText.R")
source("ReJudge/Installation/Binding/Thunk.R")

binding.of <- function(n, v) {
  binding.thunk(
    binding.oftext(
      n, v
    )
  )
}
