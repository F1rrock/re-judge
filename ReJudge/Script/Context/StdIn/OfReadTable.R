source("ReJudge/Script/Context/Context.R")
source("ReJudge/Script/Context/Lambda.R")

context.ofreadtable <- function(origin) {
  context.lambda(
    function() {
      c(
        deparse(
          quote({
            read.table = local({
              old <- utils::read.table
              function(text, col.names, ...) {
                text <- trimws(text)
                text <- text[nzchar(text)]
                old(
                  text = text,
                  col.names = col.names,
                  fill = TRUE,
                  strip.white = TRUE,
                  blank.lines.skip = TRUE,
                  ...
                )
              }
            })
          })
        ),
        core(origin)
      )
    }
  )
}
