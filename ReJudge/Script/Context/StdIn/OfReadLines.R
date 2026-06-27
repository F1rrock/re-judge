source("ReJudge/Script/Context/Context.R")
source("ReJudge/Script/Context/Lambda.R")

context.ofreadlines <- function(origin) {
  context.lambda(
    function() {
      c(
        deparse(
          quote({
            readLines = local({
              old <- base::readLines
              function(con, ...) {
                if (missing(con))
                  old(con = "stdin", ...)
                else
                  old(con = con, ...)
              }
            })
          })
        ),
        core(origin)
      )
    }
  )
}
