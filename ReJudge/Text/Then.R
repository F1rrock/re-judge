source("ReJudge/Text/Bind.R")

text.then <- function(l, r) {
  text.bind(l, function(.) r)
}
