source("ReJudge/Text/Text.R")
source("ReJudge/Text/Lambda.R")

text.interpolated <- function(template, ...) {
  text.lambda(function() {
    vals <- lapply(list(...), contents)
    template <- contents(template)
    for (nm in names(vals)) {
      template <- gsub(
        paste0("`@@`(", nm, ")"),
        vals[[nm]],
        template,
        fixed = TRUE
      )
    }
    template
  })
}
